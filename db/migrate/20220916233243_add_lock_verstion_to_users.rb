class AddLockVerstionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lock_version, :integer
  end
end
