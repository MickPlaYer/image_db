# frozen_string_literal: true

class CreateAnimes < ActiveRecord::Migration[6.0]
  def change
    create_table :animes do |t|
      t.string :title, null: false
      t.string :season, null: false

      t.timestamps
    end
  end
end
