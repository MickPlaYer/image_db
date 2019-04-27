# frozen_string_literal: true

class RemoveTitleAndSeasonFromImages < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :images, bulk: true do |t|
        dir.up do
          t.remove :title
          t.remove :season
        end

        dir.down do
          t.string :title
          t.string :season
        end
      end
    end
  end
end
