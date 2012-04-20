class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def self.test_email(address)
    mail(:to => address, :subject => "Welcome")
  end

end
