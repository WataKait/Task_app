# frozen_string_literal: true

class Task < ApplicationRecord
  has_many :labels, through: :label_tasks
  has_many :label_tasks, dependent: :destroy
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  validates :name, presence: true, format: { with: /\A[a-zA-Zぁ-んァ-ン一-龥]+\z/ }
  validates :user_id, presence: true
  validates :priority_id, presence: true
  validates :status_id, presence: true
end
