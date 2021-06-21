# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_name#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'true' }
  end
end
