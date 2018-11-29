# frozen_string_literal: true

class QueryImagesJob < ApplicationJob
  queue_as :default

  rescue_from 'RestClient::TooManyRequests', wait: 60, attempts: 15

  def perform
    Image.not_queried.find_each(batch_size: 10) do |image|
      QueryImageJob.perform_now(image.file_name)
    end
  end
end
