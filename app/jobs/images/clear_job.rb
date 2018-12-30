# frozen_string_literal: true

module Images
  class ClearJob < ApplicationJob
    queue_as :default

    def perform
      image_ids = []
      Image.find_each do |image|
        file_path = ImageDb.images_path.join(image.file_name)
        next if File.file?(file_path) && File.exist?(file_path)

        image_ids.push(image.id)
      end
      return if image_ids.blank?

      image_ids.each_slice(100) do |ids|
        Image.where(id: ids).delete_all
      end
    end
  end
end
