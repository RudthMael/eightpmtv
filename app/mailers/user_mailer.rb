class UserMailer < ActionMailer::Base
  layout "user_mailer"
  default :from => "no-reply@eightpm.tv"
  
  def new_follower(user_id, follower_id)
    @user = User.find(user_id)
    @follower = User.find(follower_id)
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(:to => @user.email, :subject => "#{@follower.name} is now following you on 8PM.TV",
         :from => "no-reply@eightpm.tv")
  end
end
