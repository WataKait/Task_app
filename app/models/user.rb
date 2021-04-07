class User < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/}
end
