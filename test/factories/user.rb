# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role { "admin" }
    status { "CURRENT_STATUS" }
    uid { Faker::Internet.uuid }
  end
end
