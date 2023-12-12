

class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new
    render :new
  end

  def create
    logger.info("entered create")
    puts params[:response]
    @response = params[:response]
    @user = User.find(current_user.id)
    user_id = @user
    response = params[:response]
    @feedback = Feedback.new(feedback_params)
    save_feedback
  end

  def save_feedback
    @feedback.user_id = current_user.id
    if @feedback.save
      puts "sending feedback"
      UserMailer.send_advice_confirmation(current_user.email, "feedback", @response).deliver_now
      ApplicationMailer.notify_company_of_advice("feedback", @response).deliver_now

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
