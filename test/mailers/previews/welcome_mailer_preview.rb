# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome_mailer/confirmation_notification
  def confirmation_notification
    WelcomeMailer.confirmation_notification
  end

end
