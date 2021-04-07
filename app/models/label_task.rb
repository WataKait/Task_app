class Label_Task < ApplicationRecord
  belongs_to :task
  belongs_to :label
  validates :label_id, presence: true
  validates :task_id, presence: true
end