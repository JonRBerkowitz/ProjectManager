class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string  :name
      t.boolean :done, :default => false
      t.integer :project_id
      t.integer :user_id
      t.datetime :due_date
      t.timestamps
    end
  end
end
