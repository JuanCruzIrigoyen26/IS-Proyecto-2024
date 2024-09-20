class CreateTrivia < ActiveRecord::Migration[7.0]
  def change
    create_table :trivias do |t|
      t.integer :number
      t.string :title
      t.text :description
      t.string :test_letter
      t.integer :game_number, foreign_key: true
      t.string :mode, default: 'beginner'

      t.timestamps
    end
  end
end