class TracksController < ApplicationController
  layout "users"
  before_action :current_user
  before_action :find_stem, except: [:index, :new, :create]

  def index
    unless user_matches_url
      flash[:error] = ["Sorry, something went wrong.",
                      "You were barking up the wrong tree."]
      redirect_to root_path
    end
    @tracks = Track.where(creator_id: current_user.id)
  end

  def show
  end

  def new
    @track = Track.new
  end

  def edit
    unless user_is_creator?
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      "You didn't create this track so you can't edit its details!"]
      redirect_to user_stems_path
    end
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
      redirect_to user_stems_path
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @track.errors.full_messages.to_sentence]
      render 'edit'
    end
  end

  def destroy
    if @track.destroy
      flash[:success] = "Sweet! Track was successfully deleted"
      redirect_to user_stems_path(params[:id])
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

    def user_is_creator?
      current_user.id == find_stem.creator_id
    end

    def track_params
      params.require(:track).permit(:download_url,
                                    :track_name,
                                    :creator_id)
    end
end
