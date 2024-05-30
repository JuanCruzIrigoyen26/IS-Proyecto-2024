class CreateTrivia < ActiveRecord::Migration[7.0]
  def change
    create_table :trivia do |t|
      t.integer :number
      t.string :title
      t.text :description
      t.string :test_letter
      t.string :mode, default: 'beginner'

      t.timestamps
    end
  end
end
