class UserMailer < ApplicationMailer
  default from: 'notifications@larion.com'

  def welcome_email(option = {})
    @user = option[:user]
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Larion Company')
  end
end
