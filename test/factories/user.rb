# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    roles { ["admin"] }
    status { "CURRENT_STATUS" }
    is_enabled { true }
    uuid { Faker::Internet.uuid }
  end
end
