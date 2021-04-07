class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.integer :user_id,  null: false
      t.integer :priority_id,  null: false
      t.datetime :time_limit
      t.text :description
      t.integer :status_id,  null: false

      t.timestamps
    end
  end
end
