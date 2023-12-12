class ReviewsController < ApplicationController
  def new
    @review = Review.new
    render :new
  end

  def create
    logger.info("entered create")
    @message = params[:message]
    @user = User.find(current_user.id)
    user_id = @user
    station_id = params[:station_id]
    @review = Review.new(review_params)

    save_review
  end

  def save_review
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Response submitted. Thank you for your feedback!"
      send_email
      redirect_to home_path
    else 
      flash.now[:error] = @review.errors.full_messages.to_sentence
      render :new, status:500
    end
  end
  
  def review_params
    params.permit(:message, :station_id, :rating)
  end

  def send_email
    logger.info("entered send email")
    from = SendGrid::Email.new(email: ENV['SENDER_EMAIL'])
    to = SendGrid::Email.new(email: @user.email)
    subject = 'ValetBike Station Review Received'
    text = "Thank you for reviewing a ValetBike station! Your feedback has been received. Below is a copy of your response.\n\n" + "\"" + @message + "\""
    content = SendGrid::Content.new(type: 'text/plain', value: text)
    mail = SendGrid::Mail.new(from, subject, to, content)
 
 
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
 
 
  end
end
