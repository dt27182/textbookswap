class User < ActiveRecord::Base
  validates :email, :uniqueness => true
	validates :email, :email => true
end
