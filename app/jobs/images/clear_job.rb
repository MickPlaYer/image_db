# frozen_string_literal: true

module Images
  class ClearJob < ApplicationJob
    THUMBS = 'thumbs'
    queue_as :default

    def perform(*arguments)
      clear_database
      clear_thumbs if THUMBS.in?(arguments)
    end

    private

    def clear_database
      image_ids = []
      Image.find_each do |image|
        file_path = ImageDb.images_path.join(image.file_name)
        next if File.file?(file_path) && File.exist?(file_path)

        thumb_path = ImageDb.thumbs_path.join("#{image.basename}.jpg")
        if File.file?(thumb_path) && File.exist?(thumb_path)
          File.delete(thumb_path)
        end
        image_ids.push(image.id)
      end
      return if image_ids.blank?

      image_ids.each_slice(100) { |ids| Image.where(id: ids).delete_all }
    end

    def clear_thumbs
      Dir.glob(ImageDb.thumbs_path.join('*.jpg')).each do |file_name|
        basename = File.basename(file_name, '.*')
        pattern = "#{ActiveRecord::Base.sanitize_sql_like(basename)}.___"
        next if Image.where('file_name like ?', pattern).exists?

        File.delete(file_name)
      end
    end
  end
end
