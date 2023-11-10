class AddRightToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :right, :integer
  end
end
