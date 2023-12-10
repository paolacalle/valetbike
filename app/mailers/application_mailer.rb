class ApplicationMailer < ActionMailer::Base
  default from: "paolacalle628@gmail.com"
  layout "mailer"

  def welcome_email(user)
    @user = user
    @url = "www.ValetBike.com"
    mail(:to => @user.email, :subject => "Welcome to ValetBike")
  end
end
