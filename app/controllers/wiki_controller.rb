# frozen_string_literal: true

class WikiController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wiki_page, only: %i[show edit update destroy]

  def main
    @latest_wiki_page = WikiPage.order(updated_at: :desc).first
    @all_wiki_pages = WikiPage.all.order(title: :asc)
  end

  def index
    @wiki_pages = WikiPage.all
  end

  def show
    @wiki_page = WikiPage.find(params[:id])
  end

  def new
    @wiki_page = WikiPage.new
  end

  def create
    @wiki_page = WikiPage.new(wiki_page_params)
    @wiki_page.user = current_user

    if @wiki_page.save
      redirect_to @wiki_page, notice: 'Wiki page was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @wiki_page.update(wiki_page_params)
      redirect_to @wiki_page, notice: 'Wiki page was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @wiki_page.destroy
    redirect_to wiki_index_path, notice: 'Wiki page was successfully deleted.'
  end

  private

  def set_wiki_page
    @wiki_page = WikiPage.find(params[:id])
  end

  def wiki_page_params
    params.require(:wiki_page).permit(:title, :content, :tag_list)
  end
end
