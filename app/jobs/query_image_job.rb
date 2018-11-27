# frozen_string_literal: true

class QueryImageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    args.present?
    random = Random.new(0)
    file_path = Dir.glob(ImageDb.images_path.join('*')).sample(random: random)
    base64 = Base64.encode64(File.open(file_path, 'rb').read)
    mime_type = MIME::Types.type_for(file_path).first.content_type
    image_data = "data:#{mime_type};base64,#{base64}"
    site = RestClient::Resource.new('https://trace.moe/api')
    search_result = JSON.parse(site['search'].post(image: image_data))
    Rails.logger.ap search_result
    return if search_result['docs'].blank?

    create_image(search_result['docs'], file_path)
  end

  private

  def create_image(docs, file_path)
    doc = docs.min_by { |d| [d['anilist_id'], d['episode']] }
    file_name = File.basename(file_path)
    image = Image.find_or_create_by(file_name: file_name)
    image.update!(doc.slice('title', 'season', 'episode'))
  end
end
