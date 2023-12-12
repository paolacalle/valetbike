

class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new
    render :new
  end

  def create
    logger.info("entered create")
    @feedback = Feedback.new(feedback_params)
    save_feedback
  end

  def save_feedback
    @feedback.user_id = current_user.id
    if @feedback.save
      UserMailer.send_feedback_confirmation(current_user.email).deliver_now
      ApplicationMailer.notify_company_of_feedback(@feedback.response).deliver_now
      flash[:success] = "Response submitted. Thank you for your feedback!"
      redirect_to home_path
    else 
      flash.now[:error] = @feedback.errors.full_messages.to_sentence
      render :new, status:500
    end
  end

  def feedback_params
    params.permit(:response)
  end

  

end
