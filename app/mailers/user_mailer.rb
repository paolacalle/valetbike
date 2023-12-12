class UserMailer < ApplicationMailer
  default from: 'bikeruby4@gmail.com'

  def send_feedback_confirmation(user_email)
    mail(to: user_email, subject: 'Valetbike Feedback Confirmation', body: 'Thank you. Your feedback was sent to bikeruby4@gmail.com for further review.')
  end

end
