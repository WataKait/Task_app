# frozen_string_literal: true

class Priority < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :priority, presence: true, numericality: true, uniqueness: true
end
