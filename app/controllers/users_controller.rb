class UsersController<ApplicationController

  def dashboard
    @circles = Circle.includes(:creator).first(5)
    @remaining_circles = Circle.count - 5
  end
end
