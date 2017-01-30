t.integer :value
t.references :user, foreign_key: true
t.references :post, foreign_key: true

t.timestamps

require 'random_data'
FactoryGirl.define do
  factory :vote do
    value 1
    user
    post
  end
end
