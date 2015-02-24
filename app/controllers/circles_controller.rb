class CirclesController < ApplicationController
  layout "users"
  before_action :current_user
  before_action :find_circle, except: [:index, :new, :create, :show]

  def index
    @circles = Circle.includes(:creator, :submissions)
    render "_index"
  end

  def new
    @circle = @current_user.circles.new
  end

  def create
    @circle = @current_user.circles.new(circle_params)
    if @circle.save
      flash[:success] = "Sweet! Circle successfully created"
      redirect_to circles_path
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @circle.errors.full_messages.to_sentence]
      render 'new'
    end
  end

  def edit
    unless user_is_creator?
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      "You didn't create this circle so you can't edit its details!"]
      redirect_to circles_path
    end
  end

  def update
    if @circle.update_attributes(circle_params)
      flash[:success] = "Sweet! Circle was successfully updated"
      redirect_to circle_path(@circle)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @circle.errors.full_messages.to_sentence]
      redirect_to edit_circle_path(@circle)
    end
  end

  def mixup
    if @circle.mixup
      flash[:success] = "Awesome! Let the remixing begin."
      redirect_to circle_path(@circle)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @circle.errors.full_messages.to_sentence]
      redirect_to circle_path(@circle)
    end
  end

  def destroy
    if @circle.destroy
      flash[:success] = "Sweet! Circle was successfully deleted"
      redirect_to user_dashboard_path(@current_user)
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @circle.errors.full_messages.to_sentence]
      redirect_to circle_path(@circle)
    end
  end

  def show
    @circle = Circle.includes(:creator, :submissions).find(params[:id])
    @circle_members = @circle.members
    @stems = @current_user.stems
    @submission = Submission.new if @circle.has_member(@current_user) == false && @circle.status == "not started"
  end

  private

    def circle_params
      params.require(:circle).permit(:name,
                                     :signup_deadline,
                                     :submit_deadline)
    end

    def find_circle
      @circle = Circle.find(params[:id])
    end

    def user_is_creator?
      current_user.id == find_circle.creator_id
    end
end
