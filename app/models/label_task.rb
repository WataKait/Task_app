class Label_Task < ApplicationRecord
  belongs_to :task
  belongs_to :label
end