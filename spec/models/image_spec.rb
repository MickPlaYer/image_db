require 'rails_helper'

RSpec.describe Image, type: :model do
  subject { described_class.create!(file_name: '1543340302.jpg') }

  it { is_expected.to be_valid }
  it { is_expected.to be_persisted }
end
