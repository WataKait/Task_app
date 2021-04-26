class Task < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  belongs_to :label
  validates :name, presence: true
end
