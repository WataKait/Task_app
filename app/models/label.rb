# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :label_tasks, dependent: :destroy
  has_many :tasks, through: :label_tasks
  validates :label, presence: true, format: { with: /\A[a-zA-Zぁ-んァ-ン一-龥]+\z/ }
end
