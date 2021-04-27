# frozen_string_literal: true

class ChangeColumnLabelsName < ActiveRecord::Migration[6.1]
  def change
    change_column(:labels, :name, :string, limit: 255)
  end
end
