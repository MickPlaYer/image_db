# frozen_string_literal: true

class QueryImageJob < ApplicationJob
  queue_as :default

  def perform(file_name)
    image = Image.find_by!(file_name: file_name)
    thumb_path = thumb_image(image)
    image_data = helpers.base64_data(thumb_path)
    site = WhatAnime.new
    response = site.search(image_data)
    search_result = JSON.parse(response)
    logger.ap search_result
    data = { queried: true }
    docs = search_result['docs']
    data.merge!(docs.first.slice('title', 'season', 'episode')) if docs.present?
    image.update!(data)
  end

  private

  def thumb_image(image)
    thumb_path = Rails.root.join('public', 'thumbs', "#{image.basename}.jpg")
    if File.exist?(thumb_path)
      thumb_path.to_s
    else
      helpers.thumb_image(image)
    end
  end
end
