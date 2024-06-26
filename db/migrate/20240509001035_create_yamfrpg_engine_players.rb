# frozen_string_literal: true

# Migration to create the table for the player model of YAMFRPG.
class CreateYamfrpgEnginePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_players do |t|
      t.references :game, null: false, foreign_key: { to_table: :yamfrpg_engine_games }
      t.references :user_role, null: false, foreign_key: { to_table: :yamfrpg_engine_user_roles }

      t.timestamps

      t.index %i[user_role_id game_id], unique: true
    end
  end
end
