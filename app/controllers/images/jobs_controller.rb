# frozen_string_literal: true

module Images
  class JobsController < ApplicationController
    OPTIONS_SIZE = 8
    OPTION_LENGTH = 128
    TYPES_MAP = {
      'query_all' => 'Images::QueryAllJob',
      'prepare' => 'Images::PrepareJob',
      'thumb' => 'Images::ThumbJob',
      'clear' => 'Images::ClearJob',
      'query' => 'Images::QueryJob'
    }.freeze

    before_action :check_job_type, :check_job_options, only: :create

    def create
      @job.perform_later(*@options)
      head :ok
    end

    private

    def check_job_type
      job = TYPES_MAP[params[:type].to_s] || ''
      @job = job.safe_constantize
      head :method_not_allowed if @job.blank?
    end

    def check_job_options
      @options = params[:options]
      return if @options.is_a?(Array) &&
                @options.size <= OPTIONS_SIZE &&
                @options.all? do |option|
                  option.is_a?(String) && option.length < OPTION_LENGTH
                end

      @options = []
    end
  end
end
