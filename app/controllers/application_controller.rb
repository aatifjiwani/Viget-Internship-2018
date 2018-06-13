class ApplicationController < ActionController::Base
  def page_title
    @page_title ||= "Haxxor News"
  end
  
  helper_method :page_title

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

end