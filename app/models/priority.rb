# frozen_string_literal: true

class Priority < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :comparison_val, presence: true, numericality: true, uniqueness: true
  validates :priority, presence: true, format: { with: /\A[a-zA-Zぁ-んァ-ン一-龥]+\z/ }, uniqueness: true
end
