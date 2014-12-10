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
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to @user
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "User was successfully updated"
      redirect_to @user
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User was successfully deleted"
      redirect_to @users_path
    else
      flash[:error] = "Something went wrong"
      redirect_to @users_path
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

end
