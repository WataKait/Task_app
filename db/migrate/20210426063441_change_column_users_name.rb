class ChangeColumnUsersName < ActiveRecord::Migration[6.1]
  def change
    change_column(:users, :name, :string, limit: 255)
  end
end
