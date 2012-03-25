class Book < ActiveRecord::Base
	has_many :postings
	has_and_belongs_to_many :courses
end
