# frozen_string_literal: true

class Status < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  def self.search(keyword)
    if keyword.present?
      Status.where('name LIKE ?', "%#{keyword}%")
    else
      Status.all
    end
  end
end
