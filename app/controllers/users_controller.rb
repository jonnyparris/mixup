class UsersController < ApplicationController
  before_action :current_user, except: [:index, :new, :create]
  before_action :reject_unless_logged_in, except: [:new, :create]

  CIRCLE_OFFSET_DEFAULT = 4

  def dashboard
    unless user_matches_url
      flash[:error] = ["Sorry, something went wrong.",
                      "You were barking up the wrong tree."]
      redirect_to root_path
    end
    @total_circles = Circle.count
    @circle_offset = params[:circle_offset].to_i
    @circles = Circle.includes(:creator).limit(CIRCLE_OFFSET_DEFAULT).offset(@circle_offset)
    @remaining_circles = @total_circles - @circle_offset - CIRCLE_OFFSET_DEFAULT
  end

  def index
    @users = User.all
  end

  def show
  end

  def new
    @current_user = User.new
    render layout: 'static_pages'
  end

  def edit
  end

  def create
    @current_user = User.new(user_params)
    if @current_user.save
      login(@current_user.id)
      flash[:success] = "Success! Welcome to your dashboard!"
      redirect_to user_dashboard_path(@current_user.id)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @current_user.errors.full_messages.to_sentence]
      render 'new', layout: 'static_pages'
    end
  end

  def update
    if @current_user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to @current_user
    else
      flash[:error] = "Something went wrong"
      render @current_users_edit_path
    end
  end

  def destroy
    if @current_user.destroy
      flash[:success] = "User was successfully deleted"
      redirect_to welcome_path
    else
      flash[:error] = "Something went wrong"
      redirect_to @current_users_path
    end
  end

  private

    def user_params
      params.require(:user).permit( :first_name,
                                    :last_name,
                                    :user_name,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :avatar,
                                    :location)
    end

    def reject_unless_logged_in
      redirect_to root_url, notice: "You must be logged in to view that page." unless current_user
    end
end
