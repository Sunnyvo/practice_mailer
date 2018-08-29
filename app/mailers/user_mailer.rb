class UserMailer < ApplicationMailer
  default from: 'notifications@larion.com'

  def welcome_email(option = {})
    @email = option[:email]
    @url  = 'http://localhost:3000/users/password/new'
    mail(to: @email, subject: 'Welcome to Larion Company')
  end
end
