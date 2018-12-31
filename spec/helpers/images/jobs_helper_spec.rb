# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Images::JobsHelper, type: :helper do
  describe '#create_job_button' do
    let(:type) { 'my_type' }
    let(:expected_button) do
      '<form class="d-inline-flex" method="post" action="/images/jobs"' \
      ' data-remote="true">' \
      '<input class="btn btn-warning" data-confirm="Really?"' \
      " type=\"submit\" value=\"#{type}\" />" \
      "<input type=\"hidden\" name=\"type\" value=\"#{type}\" /></form>"
    end

    it 'render a button to create a job' do
      allow(helper).to receive(:t).with(".#{type}") { type }
      button = helper.create_job_button(type)
      expect(button).to eq expected_button
    end
  end
end
