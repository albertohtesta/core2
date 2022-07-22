# frozen_string_literal: true

class UpdateRoleColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :string
    add_column :users, :role, :integer, null: false
  end
end
