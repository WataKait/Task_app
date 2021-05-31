# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  belongs_to :label, optional: true
  validates :name, presence: true, length: { maximum: 255 }

  def self.search(keyword, status_ids, user_id)
    if keyword.present?
      Task.where('name like ? or status_id in (?)', "%#{keyword}%", status_ids).and(Task.where('user_id = ?', user_id))
    else
      Task.where('user_id = ?', user_id).order(created_at: :desc)
    end
  end
end
