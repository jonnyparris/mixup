class TracksController < ApplicationController
  layout "users"
  before_action :find_stem, except: [:index, :new, :create]

  def index
    @tracks = Track.all
  end

  def show
  end

  def new
    @track = Track.new
  end

  def edit
  end

  def create
    @track = Track.new(params[:stem])
    if @track.save
      flash[:success] = "Track successfully created"
      redirect_to @track
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @track.errors.full_messages.to_sentence]
      render 'new'
    end
  end

  def update
    if @track.update_attributes(params[:stem])
      flash[:success] = "Track was successfully updated"
      redirect_to @track
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @track.destroy
      flash[:success] = "Track was successfully deleted"
      redirect_to user_path(params[:id])
    else
      flash[:error] = "Something went wrong"
      redirect_to edit_user_tracks_path(params[:id])
    end
  end

  private

    def find_stem
      @track = Track.find(params[:id])
    end

end
