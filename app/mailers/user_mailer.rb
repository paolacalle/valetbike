class UserMailer < ApplicationMailer
  default from: ENV['SENDER_EMAIL']

  def send_feedback_confirmation(user_email)
    mail(to: user_email, subject: 'Valetbike Feedback Confirmation', body: "Thank you. Your feedback was sent to #{ENV['SENDER_EMAIL']} for further review.")
  end

end
