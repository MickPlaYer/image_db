# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :file_name, null: false
      t.string :title
      t.string :season
      t.string :episode
      t.timestamps
    end
  end
end
