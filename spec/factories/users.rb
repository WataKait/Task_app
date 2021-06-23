# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_name#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'false' }
  end

  factory :admin, class: 'User' do
    sequence(:name) { |n| "admin_user#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'true' }
  end
end
