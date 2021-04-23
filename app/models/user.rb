class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9ぁ-んァ-ン一-龥_-]+\z/ }, uniqueness: true
end
