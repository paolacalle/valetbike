ActionMailer::Base.smtp_settings = {
  user_name: "apikey", # do not change this field
  password: "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" ,
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}