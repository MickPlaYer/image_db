# frozen_string_literal: true

class WhatAnime
  include HTTParty
  base_uri 'https://trace.moe/api'
  raise_on Range.new(400, 599).to_a.freeze

  def me
    self.class.get('/me')
  end

  def search(image_data)
    self.class.post('/search', body: { image: image_data })
  end
end
