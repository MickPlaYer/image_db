# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Anime, type: :model do
  subject { described_class.create!(title: '化物語', season: '2009-07') }

  it { is_expected.to be_valid }
  it { is_expected.to be_persisted }
end
