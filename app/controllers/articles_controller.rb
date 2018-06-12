class ArticlesController < ApplicationController
	def new
		@pg_title = "Create Post | Haxxor News"
		@article = Article.new
	end

	def create
		@article = Article.new(article_param)

		if @article.save
			redirect_to :controller => 'home', :action => 'index'
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		@article = Article.find(params[:id])
		@article.content_img.purge
		@article.destroy
		redirect_to :controller => 'home', :action => 'index'
	end

	private
	def article_param
		params.require(:article).permit(:title, :body, :content_img)
	end
end
