class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :summary
      t.integer :category
      t.date :release_date
      t.decimal :rating
      t.string :cover

      t.timestamps
    end
  end
end
