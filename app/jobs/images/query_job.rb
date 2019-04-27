# frozen_string_literal: true

module Images
  class QueryJob < ApplicationJob
    queue_as :default

    def perform(file_name)
      image = Image.find_by!(file_name: file_name)
      thumb_path = thumb_image(image)
      image_data = helpers.base64_data(thumb_path)
      site = WhatAnime.new
      response = site.search(image_data)
      search_result = JSON.parse(response.body)
      logger.ap search_result
      data = { queried: true }
      docs = search_result['docs']
      if docs.present?
        data.merge!(docs.first.slice('title', 'season', 'episode'))
      end
      image.update!(data)
    rescue HTTParty::ResponseError => error
      response = error.response
      raise unless response.server_error?

      logger.info "Got Server Error(#{response.body}), skip it just now."
    end

    private

    def thumb_image(image)
      thumb_path = ImageDb.thumbs_path.join("#{image.basename}.jpg")
      if File.exist?(thumb_path)
        thumb_path.to_s
      else
        helpers.thumb_image(image)
      end
    end
  end
end
