class CreateTodoItem < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :complete, default: false

      t.belongs_to :todo_list, index: true, foreign_key: true

      t.timestamps
    end
  end
end
