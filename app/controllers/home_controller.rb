class HomeController < ApplicationController
  def index
		@pg_title = "Home | Haxxor News"
		@articles = Article.order(id: :desc)
  end
end
