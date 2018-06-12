class ArticlesController < ApplicationController
    def new
        @pg_title = "Create Post | Haxxor News"
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
        
        if @article.save
            redirect_to :controller => 'home', :action => 'index'
        else
            render 'new'
        end
    end
    
    private
    def article_params
        params.require(:article).permit(:title, :body)
    end
end
