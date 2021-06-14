# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
end
