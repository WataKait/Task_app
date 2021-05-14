# frozen_string_literal: true

FactoryBot.define do
  factory :priority do
    sequence(:name) { |n| "priority_name#{n}" }
    sequence(:priority) { |n| n }
  end
end
