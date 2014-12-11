class TracksController < ApplicationController
  layout "users"
  before_action :find_stem, except: [:index, :new, :create]

  def index
    @tracks = Track.where(creator_id: params[:id])
  end

  def show
  end

  def new
    @track = Track.new
  end

  def edit
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = "Sweet! Track successfully created"
      redirect_to user_stems_path(params[:user_id])
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @track.errors.full_messages.to_sentence]
      render 'new'
    end
  end

  def update
    if @track.update_attributes(track_params)
      flash[:success] = "Sweet! Track was successfully updated"
      redirect_to @track
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @track.errors.full_messages.to_sentence]
      render 'edit'
    end
  end

  def destroy
    if @track.destroy
      flash[:success] = "Sweet! Track was successfully deleted"
      redirect_to user_path(params[:id])
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @track.errors.full_messages.to_sentence]
      redirect_to edit_user_tracks_path(params[:id])
    end
  end

  private

    def find_stem
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:download_url,
                                    :track_name,
                                    :creator_id)
    end
end
