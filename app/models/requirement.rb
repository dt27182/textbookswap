#This model is used to store whether a certain books is required for a certain course
class Requirement < ActiveRecord::Base
	belongs_to :book
	belongs_to :course
end
