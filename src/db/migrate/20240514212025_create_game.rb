class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :game do |t|
      t.integer :number, limit: 1, unique: true
      t.string :name
      t.string :genre

      t.timestamps
    end
    add_index :games, :number, unique:true
  end
end
