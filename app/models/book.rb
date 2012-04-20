class Book < ActiveRecord::Base
  has_many :postings
  has_many :requirements
  has_many :courses, :through => :requirements
  validates :title, :author, :edition, :isbn, :presence => true
  validates :edition, :uniqueness => {:scope => [:title, :author]}
  #validates :isbn, :isbn_format => true
end
