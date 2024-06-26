# frozen_string_literal: true

# Migration to create the table for person name model in YAMFRPG.
class CreateYamfrpgEnginePersonNames < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_person_names do |t|
      t.string :given_name
      t.string :middle_name
      t.string :surname
      t.string :suffix
      t.integer :style

      t.timestamps

      t.index %i[given_name middle_name surname suffix style], unique: true
    end
  end
end
