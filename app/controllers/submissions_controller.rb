class SubmissionsController < ApplicationController
  layout "users"
  before_action :current_user

  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      undo_link = view_context.link_to('UNDO', circle_submission_path(circle_id: @submission.circle_id, id: @submission.id), method: :delete).html_safe
      flash[:success] = "Submission successfully created - #{undo_link}"
    else
      flash[:error] = ["Sorry, something went wrong. Please try again",
                      @submission.errors.full_messages.to_sentence]
    end
    redirect_to circle_path(@submission.circle)
  end

  def edit_remix
    @submission = Submission.find_by(circle_id: params[:id], original_id: params[:stem_id])
    @tracks = @current_user.stems
  end

  def update
    find_submission
    if @submission.update_attributes(submission_params)
      flash[:success] = "Success! Remix was successfully submitted"
      redirect_to circle_path(@submission.circle)
    else
      flash[:error] = "Submission failed - something went wrong"
      redirect_to edit_remix_path(@submission)
    end
  end

  def destroy
    find_submission
    if @submission.destroy
      flash[:success] = "Submission was successfully deleted"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to circle_path(params[:circle_id])
  end

  private

    def find_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:circle_id,
                                         :original_id,
                                         :remix_id)
    end

end
