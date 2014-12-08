class UsersController<ApplicationController

  def dashboard
    @total_circles = Circle.count
    @circle_offset = params[:circle_offset].to_i
    @circles = Circle.includes(:creator).limit(5).offset(@circle_offset)
    @remaining_circles = @total_circles - @circle_offset - 5
  end
end
