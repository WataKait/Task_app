# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, format: { with: /\A[a-zA-Zぁ-んァ-ン一-龥]+\z/ }
end
