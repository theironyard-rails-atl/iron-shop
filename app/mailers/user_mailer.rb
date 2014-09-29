class UserMailer < ActionMailer::Base
  default from: "ironshop@no-reply.com"

  def price_watch_email(user, watches)
    @user = user
    @watches = watches
    mail(to: @user.email, subject: 'Price Watch')
  end

end
