# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Images::JobsController, type: :controller do
  describe '#create' do
    let(:do_request) do
      proc do |type, options|
        post :create, params: { type: type, options: options }
      end
    end

    after { clear_enqueued_jobs }

    context 'when type: nil' do
      it { expect { do_request.call }.not_to have_enqueued_job }
    end

    context 'when type: nil then result' do
      before { do_request.call }

      it { expect(response).to have_http_status :method_not_allowed }
    end

    described_class::TYPES_MAP.each do |type, job|
      context "when type: #{type.inspect}" do
        it { expect { do_request.call(type) }.to have_enqueued_job }
      end

      context "when type: #{type.inspect} then result" do
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

    context 'when type: "not_allow" then result' do
      before { do_request.call('not_allow') }

      it { expect(response).to have_http_status :method_not_allowed }
    end

    context 'when options: ["foo", "bar"]' do
      subject do
        -> { do_request.call(described_class::TYPES_MAP.keys.first, options) }
      end

      let(:options) { %w[foo bar] }

      it { is_expected.to have_enqueued_job.with(*options) }
    end
  end
end
