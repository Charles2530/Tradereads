class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.integer :type
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
