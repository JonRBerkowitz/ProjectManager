class CreateListUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :list_users do |t|
      t.integer :user_id
      t.integer :list_id
      t.string :team_name
      t.timestamps
    end
  end
end
