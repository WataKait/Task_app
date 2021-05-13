# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task_name#{n}" }
    association :user
    association :priority
    association :status
  end
end
