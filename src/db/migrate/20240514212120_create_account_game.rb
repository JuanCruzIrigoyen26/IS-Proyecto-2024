# frozen_string_literal: true

# This migration creates the games for each account table with necessary columns and indexes.
class CreateAccountGame < ActiveRecord::Migration[7.0]
  def change
    create_table :account_games do |t|
      t.references :account, foreign_key: true
      t.references :game, foreign_key: true
      t.integer :account_knowledge, default: '0'

      t.timestamps
    end
  end
end
