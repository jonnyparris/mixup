class UsersController < ApplicationController
  before_action :current_user, except: [:index, :new, :create, :new_sc, :create_from_sc]
  before_action :reject_unless_logged_in, except: [:new, :create, :new_sc, :create_from_sc]

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

  def new_sc
    user = User.new.soundcloud_client
    redirect_to user.authorize_url
  end

  def new
    @current_user = User.new
    render layout: 'static_pages'
  end

  def edit
  end

  def create_from_sc
    sc = User.new.soundcloud_client
    sc_access_token = sc.exchange_token(code: params[:code])
    me = sc.get('/me')
    @current_user = User.find_by_sc_user_id(me.id)
    already_existed = @current_user.nil? ? false: true
    if already_existed
      @current_user.sc_token = sc_access_token
    else
      @current_user = User.new(user_name: me.username,
                               location: me.email,
                               remote_avatar_url: me.avatar_url,
                               sc_user_id: me.id,
                               sc_token: sc_access_token)
    end
    if @current_user.save
      login(@current_user)
      if already_existed
        flash[:success] = "Welcome back!"
      else
        flash[:success] = "Welcome to Mixup! Hooray for easy SoundCloud signups"
      end
      redirect_to user_dashboard_path(@current_user)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @current_user.errors.full_messages.to_sentence]
      redirect_to new_user_path
    end
  end

  def create
    @current_user = User.new(user_params)
    if @current_user.save
      login(@current_user)
      flash[:success] = "Success! Welcome to your dashboard!"
      redirect_to user_dashboard_path(@current_user)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @current_user.errors.full_messages.to_sentence]
      redirect_to new_user_path
    end
  end

  def update
    if @current_user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to edit_user_path(@current_user)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @current_user.errors.full_messages.to_sentence]
      redirect_to edit_user_path(@current_user)
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
