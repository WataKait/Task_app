# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :tasks, dependent: :nullify
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
