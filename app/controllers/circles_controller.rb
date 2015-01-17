class CirclesController < ApplicationController
  layout "users"
  before_action :current_user

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

  def show
    @circle = Circle.includes(:creator, :submissions).find(params[:id])
    @circle_members = @circle.members
    @stems = @current_user.stems
    unless @circle.has_member @current_user
      @submission = Submission.new
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:name,
                                   :signup_deadline,
                                   :submit_deadline)
  end
end
