class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.includes(:circles, :stems, :remixes).find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def user_matches_url
    if params[:user_id]
      return current_user.id == params[:user_id].to_i
    else
      return current_user.id == params[:id].to_i
    end
  end

  def logout
    cookies.delete(:auth_token)
  end

  def login(user, remember_me=false)
    if remember_me
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
  end
end
