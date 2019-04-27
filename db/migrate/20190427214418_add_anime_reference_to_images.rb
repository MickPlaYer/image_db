# frozen_string_literal: true

class AddAnimeReferenceToImages < ActiveRecord::Migration[6.0]
  def change
    add_reference :images, :anime, foreign_key: true
  end
end
