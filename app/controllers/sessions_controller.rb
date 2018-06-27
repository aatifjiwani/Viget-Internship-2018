class SessionsController < ApplicationController
  def new
    @page_title = 'Sign In | Haxxor News'
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def redirect
    @auth_hash = auth_hash_test
    binding.pry
    @auth_hash = @auth_hash.inspect
  end


  def destroy
    reset_session
    redirect_to articles_path
  end
  
  private
  def auth_hash_test
    request.env['omniauth.auth']
  end
end
