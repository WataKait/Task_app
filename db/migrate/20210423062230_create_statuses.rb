class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
