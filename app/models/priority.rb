class Priority < ApplicationRecord
  has_many :tasks
  validates :comparison_val, presence: true, format: { with: /\A[0-9]+\z/}, uniqueness: true
  validates :priority, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/}, uniqueness: true
end
