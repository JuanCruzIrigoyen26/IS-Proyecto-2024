# frozen_string_literal: true

class CreateAccountTrivia < ActiveRecord::Migration[7.0]
  def change
    create_table :account_trivias do |t|
      t.boolean :trivias_completed, default: false
      t.references :account, foreign_key: true
      t.references :trivias, foreign_key: true

      t.timestamps
    end
  end
end
