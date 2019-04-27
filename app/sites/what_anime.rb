# frozen_string_literal: true

class WhatAnime
  include HTTParty
  base_uri 'https://trace.moe/api'
  codes = Range.new(400, 599).freeze
  raise_on codes

  def me
    self.class.get('/me')
  end

  def search(image_data)
    self.class.post('/search', body: { image: image_data })
  end
end
