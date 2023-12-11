

class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new
    render :new
  end

  def create
    logger.info("entered create")
    puts params[:response]
    @user = User.find(current_user.id)
    user_id = @user
    response = :response
    @feedback = Feedback.new(feedback_params)

    save_feedback
    
  end

  def save_feedback
    @feedback.user_id = current_user.id
    if @feedback.save
      puts "saved"
      send_email
      flash[:success] = "Response submitted. Thank you for your feedback!"
      redirect_to home_path
    end
  end

  def feedback_params
    params.permit(:response)
  end

  

end
