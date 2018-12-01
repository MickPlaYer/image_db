# frozen_string_literal: true

class QueryImagesJob < ApplicationJob
  queue_as :default

  def perform
    Image.not_queried.find_each(batch_size: 10) do |image|
      QueryImageJob.perform_now(image.file_name)
    end
  rescue RestClient::TooManyRequests
    @retry_count = @retry_count.to_i + 1
    return if @retry_count > 15

    sleep 60
    retry
  end
end
