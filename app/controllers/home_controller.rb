class HomeController < ApplicationController
  def index
      @pg_title = "Home | Haxxor News"
      @articles = Article.all
  end
end
