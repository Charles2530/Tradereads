class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :price
      t.text :sell_address
      t.integer :store
      t.string :state

      t.timestamps
    end
  end
end
