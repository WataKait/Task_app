class Status < ApplicationRecord
  has_many :tasks
  validates :status, presence: true
end