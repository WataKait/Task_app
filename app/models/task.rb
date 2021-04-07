class Task < ApplicationRecord
  has_many :labels, through: :label_tasks
  has_many :label_tasks
  belongs_to :user
  belongs_to :priority
  belongs_to :status
end
