class ApplicationMailer < ActionMailer::Base
  default from: 'bikeruby4@gmail.com'

  def notify_company_of_feedback(feedback_content)
    mail(to: 'bikeruby4@gmail.com', subject: 'NEW Feedback Posted', body: "The Feedback:\n#{feedback_content}")
  end
  
end
