# frozen_string_literal: true

# This migration creates the games table with necessary columns and indexes.
class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :number
      t.string :name
      t.string :genre
      t.string :image_path

      t.timestamps
    end
    add_index :games, :number, unique: true
  end
end
