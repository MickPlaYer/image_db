# frozen_string_literal: true

module ApplicationHelper
  def base64_data(path)
    base64 = Base64.encode64(File.open(path, 'rb').read)
    mime_type = MIME::Types.type_for(path).first.content_type
    "data:#{mime_type};base64,#{base64}"
  end

  def thumb_image(image)
    file_path = ImageDb.images_path.join(image.file_name).to_s
    magick = MiniMagick::Image.open(file_path)
    magick.resize '640x640' if magick.dimensions.any? { |d| d > 640 }
    magick.format 'jpg'
    magick.write(Rails.root.join('public', 'thumbs', "#{image.basename}.jpg"))
    magick.path
  end
end
