class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.includes(:circles,:stems,:remixes).find(session[:user_id]) if session[:user_id]
  end

  def logout
    session[:user_id] = nil
  end

  def login(user_id)
    session[:user_id] = user_id
  end
end
