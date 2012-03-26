class Book < ActiveRecord::Base
	has_many :postings
	has_many :requirements
	has_many :courses, :through => :requirements
end
