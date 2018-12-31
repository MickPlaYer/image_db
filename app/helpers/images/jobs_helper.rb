# frozen_string_literal: true

module Images
  module JobsHelper
    def create_job_button(type, *options)
      button_to t(".#{type}"),
                images_jobs_path,
                params: { type: type, options: options },
                remote: true,
                method: :post,
                class: 'btn btn-warning',
                form: { class: 'd-inline-flex' },
                data: { confirm: 'Really?' }
    end
  end
end
