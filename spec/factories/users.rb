# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'somePassword' }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
