class CreateAnswer < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.integer :number
      t.boolean :correct, default: false
      t.text :description
      t.integer :question_number, foreign_key: true
      t.string :test_letter, foreign_key: true
      t.integer :game_number, foreign_key: true

      t.timestamps
    end
  end
end
