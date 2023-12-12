class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']

  def notify_company_of_advice(type, content)
    mail(to: ENV['SENDER_EMAIL'], subject: "NEW #{type} Posted", body: "The #{type}:\n#{content}")
  end
  
end
