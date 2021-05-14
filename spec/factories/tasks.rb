# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task_name#{n}" }
    association :user
    association :label
    association :priority
    association :status
    time_limit { Time.zone.now }
    description { 'description' }
  end
end
