class CreatePriorities < ActiveRecord::Migration[6.1]
  def change
    create_table :priorities do |t|
      t.string :name, null: false
      t.integer :priority, null: false

      t.timestamps
    end
  end
end
