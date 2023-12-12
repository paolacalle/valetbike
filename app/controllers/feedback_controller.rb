

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
      send_email
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

  def send_email
    logger.info("entered send email")
    from = SendGrid::Email.new(email: 'bikeruby4@gmail.com')
    to = SendGrid::Email.new(email: @user.email)
    subject = 'ValetBike Feedback Received'
    text = "Thank you for submitting feedback to ValetBike! Your feedback has been received. Below is a copy of your response.\n\n" + "\"" + @response + "\""
    content = SendGrid::Content.new(type: 'text/plain', value: text)
    mail = SendGrid::Mail.new(from, subject, to, content)
 
 
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
 
 
  end
 

end
