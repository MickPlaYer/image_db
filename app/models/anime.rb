# frozen_string_literal: true

class Anime < ApplicationRecord
  validates :title, :season, presence: true
  has_many :images, dependent: :restrict_with_exception
end
