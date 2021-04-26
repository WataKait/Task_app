class Priority < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :priority, presence: true, numericality: true, uniqueness: true, length: { maximum: 255 }
end
