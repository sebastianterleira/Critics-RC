class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :role
      t.integer :critics_count, default: 0

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end