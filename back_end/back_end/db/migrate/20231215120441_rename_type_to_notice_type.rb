class RenameTypeToNoticeType < ActiveRecord::Migration[7.0]
  def change
    rename_column :notices, :type, :notice_type
  end
end
