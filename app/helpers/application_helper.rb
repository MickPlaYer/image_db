# frozen_string_literal: true

module ApplicationHelper
  def base64_data(path)
    file = File.open(path, 'rb')
    base64 = Base64.encode64(file.read)
    mime_type = MIME::Types.type_for(path.to_s).first.content_type
    "data:#{mime_type};base64,#{base64}"
  ensure
    file.close if file
  end
end
