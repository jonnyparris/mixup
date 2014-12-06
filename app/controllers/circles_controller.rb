class CirclesController<ApplicationController

  def index
    @circles = Circle.all
    render "_index"
  end

end
