class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :summary
      t.date :release_date
      t.integer :category
      t.decimal :rating
      t.references :parent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
