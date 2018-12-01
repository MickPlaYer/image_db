# frozen_string_literal: true

module ImagesHelper
  def thumb_image(image)
    file_path = ImageDb.images_path.join(image.file_name).to_s
    magick = MiniMagick::Image.open(file_path)
    magick.resize '640x640' if magick.dimensions.any? { |d| d > 640 }
    magick.format 'jpg'
    magick.write(Rails.root.join('public', 'thumbs', "#{image.basename}.jpg"))
    magick.path
  end

  def thumb_path(image)
    "#{root_path}thumbs/#{image.basename}.jpg"
  end
end
