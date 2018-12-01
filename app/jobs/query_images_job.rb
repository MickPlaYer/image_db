# frozen_string_literal: true

class QueryImagesJob < ApplicationJob
  queue_as :default

  rescue_from 'HTTParty::ResponseError' do |error|
    logger.ap 'rescue_from \'HTTParty::ResponseError\''
    if error.response.is_a?(Net::HTTPTooManyRequests) && executions < 15
      retry_job wait: 1.minute
    end
  end

  def perform
    Image.not_queried.find_each(batch_size: 10) do |image|
      QueryImageJob.perform_now(image.file_name)
    end
  end
end
