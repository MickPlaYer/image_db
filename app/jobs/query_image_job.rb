# frozen_string_literal: true

class QueryImageJob < ApplicationJob
  queue_as :default

  def perform(file_name)
    @image = Image.find_by!(file_name: file_name)
    @image_data = base64_data(@image.file_name)
    site = RestClient::Resource.new('https://trace.moe/api')
    search_result = JSON.parse(site['search'].post(image: @image_data))
    Rails.logger.ap search_result
    data = { queried: true }
    docs = search_result['docs']
    data.merge!(docs.first.slice('title', 'season', 'episode')) if docs.present?
    @image.update!(data)
  end

  private

  def base64_data(file_name)
    file_path = ImageDb.images_path.join(file_name).to_s
    thumb_path = thumb_image(file_path)
    base64 = Base64.encode64(File.open(thumb_path, 'rb').read)
    mime_type = MIME::Types.type_for(thumb_path).first.content_type
    "data:#{mime_type};base64,#{base64}"
  end

  def thumb_image(file_path)
    basename = File.basename(file_path, '.*')
    magick = MiniMagick::Image.open(file_path)
    magick.resize '640x640' if magick.dimensions.any? { |d| d > 640 }
    magick.format 'jpg'
    magick.write(Rails.root.join('public', 'thumbs', "#{basename}.jpg"))
    magick.path
  end
end
