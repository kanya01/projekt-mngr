# frozen_string_literal: true

# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = current_user.projects
    @projects = [] if @projects.nil?

    @projects = @projects.where('title ILIKE ?', "%#{params[:search]}%") if params[:search].present?

    @projects = case params[:sort]
                when 'title' then @projects.order(:title)
                when 'start_date' then @projects.order(:start_date)
                when 'progress' then @projects.order(:progress)
                else @projects.order(created_at: :desc)
                end

    @projects = @projects.page(params[:page]).per(10)
  end

  def show; end

  def new
    @project = current_user.projects.build
    # rescue NoMethodError
    # @project = Project.new( user: current_user)
  end

  def create
    @project = current_user.projects.build(project_params)
    Rails.logger.debug "@project.inspect: #{@project.inspect}"
    Rails.logger.debug "project_params: #{project_params.inspect}"
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  # ... other actions ...

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :start_date, :end_date, :progress)
  end
end
