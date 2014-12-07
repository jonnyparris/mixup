class UsersController<ApplicationController

  def dashboard
    @circles = Circle.all
  end
end
