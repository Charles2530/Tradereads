class AddColumnToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :score_per, :decimal
  end
end
