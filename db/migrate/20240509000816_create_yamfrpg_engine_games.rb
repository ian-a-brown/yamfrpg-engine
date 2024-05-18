# frozen_string_literal: true

# Migration to create the table for the game model of YAMFRPG.
class CreateYamfrpgEngineGames < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_games do |t|
      t.references :owner, null: false, foreign_key: { to_table: :yamfrpg_engine_users }
      t.string :game_name, null: false

      t.timestamps

      t.index :game_name, unique: true
    end
  end
end
