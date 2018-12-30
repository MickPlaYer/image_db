# frozen_string_literal: true

namespace :job do
  task log_to_stdout: :environment do
    Rails.logger = Logger.new(STDOUT)
  end

  jobs_path = Rails.root.join('app', 'jobs')
  jobs_suffix = '_job'
  Dir.glob(jobs_path.join("**/*#{jobs_suffix}.rb")).each do |file_path|
    class_name = file_path.remove("#{jobs_path}/", /\.rb$/)
    task_name = class_name.remove(/#{jobs_suffix}$/).tr('/', ':')
    next if task_name == 'application'

    desc "Perform #{class_name.classify} now"
    task task_name => :environment do |_task, args|
      job_class = class_name.classify.constantize
      job_class.perform_now(*args.extras)
    end
    task task_name => :log_to_stdout

    namespace task_name do
      task later: :environment do |_task, args|
        job_class = class_name.classify.constantize
        job_class.perform_later(*args.extras)
      end
      task later: :log_to_stdout
    end
  end
end
