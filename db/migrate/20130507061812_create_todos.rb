class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.date :due
      t.string :task
      t.string :generate
      t.string :scaffold
      t.string :calender_todo

      t.timestamps
    end
  end
end
