class Status < ApplicationRecord
  has_many :tasks
  validates :status, presence: true, length: { maximum: 10 }
end
