class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']

  def notify_company_of_feedback(feedback_content)
    mail(to: ENV['SENDER_EMAIL'], subject: 'NEW Feedback Posted', body: "The Feedback:\n#{feedback_content}")
  end
  
end
