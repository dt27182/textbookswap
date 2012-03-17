class Course < ActiveRecord::Base
  #Validates the same course isn't added twice
  validates :term, :uniqueness => { :scope => [ :number, :name, :department_short, :department_long, :teacher, :section, :year ] }
end
