class Task < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  belongs_to :label
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9ぁ-んァ-ン一-龥_-]+\z/ }
  validates :description, format: { with: /\A[a-zA-Z0-9ぁ-んァ-ン一-龥_-]+\z/ }
end
