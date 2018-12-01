# frozen_string_literal: true

module ApplicationHelper
  def base64_data(path)
    base64 = Base64.encode64(File.open(path, 'rb').read)
    mime_type = MIME::Types.type_for(path).first.content_type
    "data:#{mime_type};base64,#{base64}"
  end
end
