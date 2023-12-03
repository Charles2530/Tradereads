class AddColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :check_state, :integer
  end
end
