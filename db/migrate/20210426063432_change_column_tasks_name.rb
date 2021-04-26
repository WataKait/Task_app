class ChangeColumnTasksName < ActiveRecord::Migration[6.1]
  def change
    change_column(:tasks, :name, :string, limit: 255)
  end
end
