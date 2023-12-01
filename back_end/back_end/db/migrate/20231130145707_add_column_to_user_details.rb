class AddColumnToUserDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :user_details, :avatar, :string
  end
end
