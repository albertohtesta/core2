# frozen_string_literal: true

# Add enable column
class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_enabled, :boolean, default: true
  end
end
