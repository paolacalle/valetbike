ActionMailer::Base.smtp_settings = {
  user_name: "apikey", # do not change this field
  password:  ENV["SENDGRID_API_KEY"], 
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}