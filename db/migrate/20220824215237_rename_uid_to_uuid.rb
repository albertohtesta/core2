class RenameUidToUuid < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :uid, :uuid
  end
end
