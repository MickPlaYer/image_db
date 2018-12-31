# frozen_string_literal: true

module Images
  class ThumbJob < ApplicationJob
    queue_as :default

    def perform(*_args)
      Image.find_each do |image|
        thumb_path = ImageDb.thumbs_path.join("#{image.basename}.jpg")
        next if File.exist?(thumb_path)

        helpers.thumb_image(image)
      end
    end
  end
end
