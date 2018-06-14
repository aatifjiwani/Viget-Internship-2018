class ApplicationController < ActionController::Base
  def page_title
    @page_title ||= "Haxxor News"
  end
  
  helper_method :page_title

  def current_user
    @current_user ||= (User.find(session[:user_id]) if session[:user_id])
  end
  
  helper_method :current_user
  
  def logged_in 
    unless session[:user_id]
      redirect_to new_sessions_path
    end
  end
  
  helper_method :logged_in
end