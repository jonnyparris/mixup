class UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]

  def dashboard
    @total_circles = Circle.count
    @circle_offset = params[:circle_offset].to_i
    @circles = Circle.includes(:creator).limit(5).offset(@circle_offset)
    @remaining_circles = @total_circles - @circle_offset - 5
  end

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Success! Welcome to your dashboard!"
      redirect_to user_dashboard_path(@user.id)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again", @user.errors.full_messages.to_sentence ]
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to @user
    else
      flash[:error] = "Something went wrong"
      render @users_edit_path
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User was successfully deleted"
      redirect_to welcome_path
    else
      flash[:error] = "Something went wrong"
      redirect_to @users_path
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password_digest, :password_confirmation, :avatar, :location)
    end

end
