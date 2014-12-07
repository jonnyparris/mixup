class UsersController<ApplicationController

  def dashboard
    @circles = Circle.includes(:creator).limit(5).offset(params[:circle_offset])
    @remaining_circles = Circle.count - params[:circle_offset].to_i - 5
  end
end
