# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  belongs_to :label, optional: true
  validates :name, presence: true, length: { maximum: 255 }
end
