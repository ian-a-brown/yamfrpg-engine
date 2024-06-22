# frozen_string_literal: true

# Creates a model to control login sessions.
class CreateYamfrpgEngineLoginSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_login_sessions do |t|
      t.references :user, null: false, foreign_key: { to_table: :yamfrpg_engine_users }
      t.string :token, null: false
      t.string :uuid, null: false
      t.datetime :expires, null: false

      t.timestamps

      t.index :uuid, unique: true
      t.index %i[uuid token], unique: true
    end
  end
end
