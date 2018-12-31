# frozen_string_literal: true

module Images
  class JobsController < ApplicationController
    TYPES_MAP = {
      'query_all' => 'Images::QueryAllJob',
      'prepare' => 'Images::PrepareJob',
      'thumb' => 'Images::ThumbJob',
      'clear' => 'Images::ClearJob'
    }.freeze

    before_action :check_job_type, only: :create

    def create
      @job.perform_later
      head :ok
    end

    private

    def check_job_type
      job = TYPES_MAP[params[:type].to_s] || ''
      @job = job.safe_constantize
      head :method_not_allowed if @job.blank?
    end
  end
end
