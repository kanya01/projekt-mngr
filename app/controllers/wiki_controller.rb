class WikiController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wiki_page, only: [:show, :edit, :update, :destroy]

  def index
    @wiki_pages = WikiPage.all
  end

  def show
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

  def edit
  end

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
    params.require(:wiki_page).permit(:title, :content)
  end
end
