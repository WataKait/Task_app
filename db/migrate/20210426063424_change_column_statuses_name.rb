# frozen_string_literal: true

class ChangeColumnStatusesName < ActiveRecord::Migration[6.1]
  def change
    change_column(:statuses, :name, :string, limit: 255)
  end
end
