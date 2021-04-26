class Task < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  has_one :label, dependent: :nullify
  validates :name, presence: true, length: { maximum: 255 }
end
