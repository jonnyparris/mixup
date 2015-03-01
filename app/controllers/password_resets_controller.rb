class PasswordResetsController < ApplicationController
  layout 'static_pages'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "Check your email for password reset instructions, then hurry back here for joyful fun times!"
    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_sent_at < 2.hours.ago
      flash[:error] = ["Sorry, something went wrong. Please try again",
                       @user.errors.full_messages.to_sentence]
      redirect_to new_password_reset_path
    elsif @user.update_attributes(password_params)
      flash[:success] = "Success! Password has been reset."
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
