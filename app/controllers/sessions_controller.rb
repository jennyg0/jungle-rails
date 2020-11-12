class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/'
    else
      redirect to '/login'
    end
  end

  def destroy
    session[:user_id] = null
    redirect to '/login'
  end

end
