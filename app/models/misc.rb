class Misc < ActiveRecord::Base
  validates :key, :uniqueness => true
end
