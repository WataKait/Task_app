# frozen_string_literal: true

class Status < ApplicationRecord
  has_many :tasks
  validates :status, presence: true, length: { maximum: 10 }
end
