# frozen_string_literal: true

module Images
  module JobsHelper
    def create_job_button(type)
      button_to t(".#{type}"),
                images_jobs_path(type: type),
                remote: true,
                method: :post,
                class: 'btn btn-warning',
                form: { class: 'd-inline-flex' },
                data: { confirm: 'Really?' }
    end
  end
end
