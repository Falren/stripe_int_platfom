class UserMailer < ApplicationMailer
  default from:  'hello@dungeon.com'

  def welcome
    @greeting = "Welcome to the club, buddy!"

    mail to: "to@example.org", subject: "this is our subject"
  end
end
