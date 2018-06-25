require 'action_view'
class ArticlesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  
  before_action :require_logged_in, only: [:create, :destroy, :new]
  
  def new
    @page_title = "Create Post | Haxxor News"
    @article = Article.new
  end

  def index
    @page_title = "Home | Haxxor News"
    if params[:article_options]
      case params[:article_options]
        when "Most Recent"
        @articles = Article.order(id: :desc)
        when "All-Time Top Rated"
        @articles = article_records(Vote.article_top_10)
        when "Yearly Top Rated"
        @articles = article_records(Vote.article_top_10_year)
        when "Monthly Top Rated"
        @articles = article_records(Vote.article_top_10_month)
        when "Daily Top Rated"
        @articles = article_records(Vote.article_top_10_day)
      end
    else
      @articles = Article.order(id: :desc)
    end
    
    @current_selection = params[:article_options] || "Most Recent"
  end

  def create
    @current_user = current_user
    @article = @current_user.articles.new(article_params)

    if @article.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @page_title = "View Article | Haxxor News"
    @article = Article.find(params[:id])
    @comment = @article.comments.new
  end

  def destroy
    @article = Article.find(params[:id])
    @article.votes.destroy
    @article.destroy
    redirect_to root_url
  end
  
  #Crops the text to 160 chars and adds '...' to the end
  def preview_body(body)
    strip_tags(body)[0..155].gsub(/\s\w+\s*$/,'...')
  end
  helper_method :preview_body

  private
  def article_params
    params.require(:article).permit(:title, :body, :content_img)
  end
  
  def array_of_ids(hash)
    hash.sort_by {|k,v| -v}.to_h.keys
  end
  
  def article_records(hash)
    arr = array_of_ids(hash)
    arr.map! {|x| Article.find(x)}
  end
end
