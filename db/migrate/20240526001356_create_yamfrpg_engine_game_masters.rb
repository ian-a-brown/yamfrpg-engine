# frozen_string_literal: true

# Migration to create the table for the game master model of YAMFRPG.
class CreateYamfrpgEngineGameMasters < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_game_masters do |t|
      t.references :game, null: false, foreign_key: { to_table: :yamfrpg_engine_games }
      t.boolean :owner, null: true
      t.references :user_role, null: false, foreign_key: { to_table: :yamfrpg_engine_user_roles }

      t.timestamps
    end
  end
end
