class Status < ApplicationRecord
  has_many :tasks
  validates :status, presence: true, length: { maximum: 3 }
end
