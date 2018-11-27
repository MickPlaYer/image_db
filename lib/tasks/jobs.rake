# frozen_string_literal: true

namespace :jobs do
  jobs_path = Rails.root.join('app', 'jobs')
  jobs_suffix = '_job'
  Dir.glob(jobs_path.join("*#{jobs_suffix}.rb")).each do |file_path|
    class_name = file_path.remove("#{jobs_path}/", /\.rb$/)
    task_name = class_name.remove(/#{jobs_suffix}$/)
    desc "Perform #{class_name.classify} now"
    task task_name => :environment do |_task, args|
      Rails.logger = Logger.new(STDOUT)
      job_class = class_name.classify.constantize
      job_class.perform_now(*args.extras)
    end
  end
end
