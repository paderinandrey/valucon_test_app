class FeedbacksController < ApplicationController
  def index
    respond_with Feedback.all
  end

  def create
    render json: Feedback.create(feedback_params), serializer: FeedbackSerializer
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :text)
  end
end
