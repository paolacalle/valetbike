class UserMailer < ApplicationMailer
  default from: ENV['SENDER_EMAIL']

  def send_advice_confirmation(user_email, type, content)
    mail(to: user_email, 
          subject: "ValetBike Station #{type} Received", 
          body: "Thank you for reviewing a ValetBike station! Your #{type} has been received. Below is a copy of your response.\n\n" + "\"" + content + "\"")
  end

end
