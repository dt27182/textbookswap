FactoryGirl.define do
  factory :book do
    title 'a book'
    author 'bill bob'
    edition '1'
    isbn '0000000000000'
    suggested_price '10'
    reserved 'false'
  end
end
