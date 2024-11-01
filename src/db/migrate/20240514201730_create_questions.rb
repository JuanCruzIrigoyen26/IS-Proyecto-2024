# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :number
      t.text :description
      t.string :test_letter
      t.integer :game_number, foreign_key: true

      t.timestamps
    end
  end
end
