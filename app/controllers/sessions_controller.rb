class SessionsController < ApplicationController
  layout 'static_pages'

  def new
    logout
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login(user, params[:remember_me])
      flash[:success] = "Welcome back!"
      if params[:next_step] == "create_circle"
        redirect_to new_circle_path
      else
        redirect_to user_dashboard_path(user.id)
      end
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
