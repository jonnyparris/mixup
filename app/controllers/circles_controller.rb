class CirclesController < ApplicationController

  def index
    @circles = Circle.includes(:creator)
    render "_index"
  end

end
