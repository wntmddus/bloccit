require 'random_data'
FactoryGirl.define do
  factory :comment do
    body 'Comment Body'
    post 
    user
  end
end
