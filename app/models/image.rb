# frozen_string_literal: true

class Image < ApplicationRecord
  validates :file_name, presence: true

  enum queried: { queried: true, not_queried: false }

  def basename
    File.basename(file_name, '.*')
  end
end
