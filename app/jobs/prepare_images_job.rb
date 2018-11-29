# frozen_string_literal: true

class PrepareImagesJob < ApplicationJob
  queue_as :default

  def perform
    file_paths = Dir.glob(ImageDb.images_path.join('*'))
    file_paths.each_slice(100) do |paths|
      file_names = paths.map { |path| File.basename(path) }
      image_file_names = Image.where(file_name: file_names).pluck(:file_name)
      images = (file_names - image_file_names).map do |file_name|
        Image.new(file_name: file_name)
      end
      Image.import images
    end
  end
end
