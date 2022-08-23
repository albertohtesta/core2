# frozen_string_literal: true

class AddRolesToUsersAndRemoveRole < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :roles, :string

    User.find_each do |user|
      if user.role?
        user.roles = [user.role]
        user.save
      end
    end

    remove_column :users, :role
  end
end
