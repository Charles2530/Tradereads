class CreateUserDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :user_details do |t|
      t.references :User, null: false, foreign_key: true, unique: true
      t.string :password
      t.string :user_name
      t.text :buy_address
      t.string :gender
      t.text :pay_type

      t.timestamps
    end
  end
end
