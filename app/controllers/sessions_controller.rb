class SessionsController < ApplicationController
  layout 'static_pages'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      login(user.id)
      flash[:success] = "Welcome back!"
      redirect_to user_dashboard_path(user.id)
    else
      flash.now[:error] = ["Nah mate.","Your login failed."]
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = "Logged out successfully. We'll miss you xx"
    redirect_to root_url
  end
end
