# frozen_string_literal: true

# Migration to create the table for the player model of YAMFRPG.
class CreateYamfrpgEnginePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_players do |t|
      t.references :user, null: false, foreign_key: { to_table: :yamfrpg_engine_users }
      t.references :game, null: false, foreign_key: { to_table: :yamfrpg_engine_games }

      t.timestamps

      t.index %i[user_id game_id], unique: true
    end
  end
end
