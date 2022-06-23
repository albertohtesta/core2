# frozen_string_literal: true

# generate user model
class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: { unique: true }, null: false
      t.string :role
      t.string :status
      t.string :uid, index: { unique: true }

      t.timestamps
    end
  end
end
