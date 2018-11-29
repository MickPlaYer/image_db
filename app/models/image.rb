# frozen_string_literal: true

class Image < ApplicationRecord
  validates :file_name, presence: true

  enum queried: { queried: true, not_queried: false }
end
