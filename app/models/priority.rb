class Priority < ApplicationRecord
  has_many :tasks
  validates :comparison_val, presence: true
  validates :priority, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/}
end