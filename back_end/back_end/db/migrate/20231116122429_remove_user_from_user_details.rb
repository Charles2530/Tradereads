class RemoveUserFromUserDetails < ActiveRecord::Migration[7.0]
  def change
    remove_reference :user_details, :User, null: false, foreign_key: true
  end
end
