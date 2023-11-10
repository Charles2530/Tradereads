class CreateProductDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :product_details do |t|
      t.references :product, null: false, foreign_key: true
      t.text :product_name
      t.string :product_image
      t.text :product_press
      t.string :product_type

      t.timestamps
    end
  end
end
