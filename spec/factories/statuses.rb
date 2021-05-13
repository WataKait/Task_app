# frozen_string_literal: true

FactoryBot.define do
  factory :status do
    sequence(:name) { |n| "status_name#{n}" }
  end
end
