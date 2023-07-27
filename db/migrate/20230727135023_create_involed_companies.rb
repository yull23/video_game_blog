class CreateInvoledCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :involed_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.boolean :developer
      t.boolean :publisher

      t.timestamps
    end
  end
end
