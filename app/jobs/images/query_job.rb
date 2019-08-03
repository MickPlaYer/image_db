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
      doc = search_result['docs'].try(:first)
      save_doc_to_db(doc) if doc.present?
    rescue HTTParty::ResponseError => error
      response = error.response
      raise unless response.code == 500

      logger.info "Got Server Error(#{response.body}), skip it just now."
    end

    private

    def save_doc_to_db(doc)
      anime_data = { title: doc['title'], season: doc['season'] }
      imag_data = { queried: true, episode: doc['episode'] }
      ActiveRecord::Base.transaction do
        anime = Anime.find_or_create_by!(anime_data)
        imag_data[:anime_id] = anime.id
        image.update!(imag_data)
      end
    rescue ActiveRecord::RecordInvalid
      image.update!(queried: true)
    end

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
