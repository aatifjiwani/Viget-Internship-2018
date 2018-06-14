require 'action_view'
class ArticlesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  
  def new
    @page_title = "Create Post | Haxxor News"
    @article = Article.new
  end

  def index
    @page_title = "Home | Haxxor News"
    @articles = Article.order(id: :desc)
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @page_title = "View Article | Haxxor News"
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_url
  end
  
  #Crops the text to 160 chars and adds '...' to the end
  def preview_body(body)
    strip_tags(body)[0..160].gsub(/\s\w+\s*$/,'...')
  end
  helper_method :preview_body

  private
  def article_params
    params.require(:article).permit(:title, :body, :content_img)
  end
end
