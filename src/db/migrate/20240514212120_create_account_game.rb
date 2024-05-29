class CreateAccountGame < ActiveRecord::Migration[7.0]
  def change
    create_table :account_games do |t|
      t.references :account, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end

    add_column :account_games, :account_knowledge, :enum, default: 'basic', limit: [:basic, :medium, :advance]
  end
end
