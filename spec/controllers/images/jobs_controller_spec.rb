# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Images::JobsController, type: :controller do
  describe '#create' do
    let(:do_request) { proc { |type| post :create, params: { type: type } } }

    after { clear_enqueued_jobs }

    context 'when type: nil' do
      it { expect { do_request.call }.not_to have_enqueued_job }
    end

    context 'when type: nil and result' do
      before { do_request.call }

      it { expect(response).to have_http_status :method_not_allowed }
    end

    described_class::TYPES_MAP.each do |type, job|
      context "when type: #{type.inspect}" do
        it { expect { do_request.call(type) }.to have_enqueued_job }
      end

      context "when type: #{type.inspect} and result" do
        before { do_request.call(type) }

        it "#{job} be enqueued" do
          expect(job.constantize).to have_been_enqueued
        end
        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when type: "not_allow"' do
      it { expect { do_request.call('not_allow') }.not_to have_enqueued_job }
    end

    context 'when type: "not_allow" and result' do
      before { do_request.call('not_allow') }

      it { expect(response).to have_http_status :method_not_allowed }
    end
  end
end
