class CreateAccountGame < ActiveRecord::Migration[7.0]
  def change
    create_table :account_game do |t|
      t.references :account, foreign_key: true
      t.references :game, foreign_key: true
      t.string :account_knowledge, default: 'basic' 

      t.timestamps
    end
  end
end
