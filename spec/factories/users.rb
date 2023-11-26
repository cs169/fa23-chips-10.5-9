# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name) { |n| "Doe#{n}" }
    sequence(:uid) { |n| "uid#{n}" }
    provider { 'google_oauth2' }
  end
end
