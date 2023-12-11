

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

  

  def send_email
    puts "entered send email"
    from = SendGrid::Email.new(email: 'bikeruby4@gmail.com')
    puts "from made"
    to = SendGrid::Email.new(email: @user.email)
    puts "to made"
    subject = 'Sending with Twilio SendGrid is Fun'
    puts "subject made"
    content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    puts "content made"
    mail = SendGrid::Mail.new(from, subject, to, content)
    puts "formed"

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    puts "sg done"
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.parsed_body
    puts response.headers


  end
end
