class ArticlesController < ApplicationController
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

  private
  def article_params
    params.require(:article).permit(:title, :body, :content_img)
  end
end
