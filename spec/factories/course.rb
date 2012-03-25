

FactoryGirl.define do
  factory :course do
    term 'spring'
    number '169'
    name 'Software Engineer'
    department_short 'CS'
    department_long 'Computer Science'
    teacher 'Armando Fox'
    section '0'
    year '2012'
  end
end
