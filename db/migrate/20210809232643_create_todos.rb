class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :note
      t.date :expiration_date
      t.boolean :done

      t.timestamps
    end
  end
end
