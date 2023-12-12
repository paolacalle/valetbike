class ApplicationMailer < ActionMailer::Base
  def notify_company_of_feedback(feedback_content)
    mail(to: 'bikeruby4@gmail.com', subject: 'NEW Feedback Posted', body: "The Feedback:\n#{feedback_content}")
  end
end
