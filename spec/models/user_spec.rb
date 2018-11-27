# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.create!(name: 'Mick') }

  it { is_expected.to be_valid }
  it { is_expected.to be_persisted }
end
