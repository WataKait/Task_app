class Label < ApplicationRecord
  has_many :tasks, through: :label_tasks
  has_many :label_tasks
  validates :priority, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/}
end