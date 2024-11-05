# frozen_string_literal: true

# This migration creates the accounts table with necessary columns and indexes.
class CreateAccount < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :name
      t.string :nickname
      t.string :password
      t.integer :progress, default: 0
      t.integer :admin, default: 0

      t.timestamps
    end
  end
end
