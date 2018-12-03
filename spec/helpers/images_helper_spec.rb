# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesHelper, type: :helper do
  let(:image) { create(:image, :bakemonogatari) }

  describe '#thumb_image' do
    after do
      ImageDb.thumbs_path.glob('*.jpg').map(&:unlink)
    end

    it 'convert image to thumb version' do
      thumb_path = helper.thumb_image(image)
      expect(File).to exist thumb_path
    end
  end

  describe '#thumb_path' do
    it 'return images\'s public thumb path' do
      thumb_path = helper.public_thumb_path(image)
      expect(thumb_path).to eq "/thumbs/#{image.basename}.jpg"
    end
  end
end
