class CreateTrivia < ActiveRecord::Migration[7.0]
  def change
    create_table :trivias do |t|
      t.integer :number
      t.string :title
      t.text :description
    
      t.timestamps
    end
    add_column :trivias, :mode, :enum, default: 'beginner', limit: [:beginner, :casual, :professional]
  end
end
