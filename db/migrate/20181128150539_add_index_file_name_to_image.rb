# frozen_string_literal: true

class AddIndexFileNameToImage < ActiveRecord::Migration[5.2]
  def change
    add_index :images, :file_name
  end
end
