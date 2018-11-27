# frozen_string_literal: true

class Image < ApplicationRecord
  validates :file_name, presence: true
end
