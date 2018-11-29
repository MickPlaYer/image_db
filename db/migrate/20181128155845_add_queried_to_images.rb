# frozen_string_literal: true

class AddQueriedToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :queried, :boolean, null: false, default: false
  end
end
