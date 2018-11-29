# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  delegate :helpers, to: 'ApplicationController'
end
