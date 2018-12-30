# frozen_string_literal: true

module Images
  class QueryAllJob < ApplicationJob
    queue_as :default

    rescue_from 'HTTParty::ResponseError' do |error|
      if error.response.is_a?(Net::HTTPTooManyRequests) && executions < 15
        retry_job wait: 1.minute
      end
    end

    def perform
      Image.not_queried.find_each(batch_size: 10) do |image|
        QueryJob.perform_now(image.file_name)
      end
    end
  end
end
