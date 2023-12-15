class CreateNoticeRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :notice_records do |t|
      t.references :notice, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :readed

      t.timestamps
    end
  end
end
