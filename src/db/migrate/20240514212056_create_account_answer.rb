# frozen_string_literal: true

class CreateAccountAnswer < ActiveRecord::Migration[7.0]
  def change
    create_table :account_answers do |t|
      t.boolean :correct, default: false
      t.references :account, foreign_key: true
      t.references :answer, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
