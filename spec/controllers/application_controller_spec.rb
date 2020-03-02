# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#homepage' do
    let!(:images) do
      [
        create(:image, :bakemonogatari),
        create(:image, :toradora)
      ]
    end

    before { get :homepage }

    it { expect(response).to have_http_status(:ok) }

    it 'has images' do
      expect(assigns[:images]).to eq images.reverse
    end

    it 'has titles' do
      expect(assigns[:titles]).to eq images.map(&:anime).map(&:title)
    end

    it 'has title' do
      expect(assigns[:title]).to be_in images.map(&:anime).map(&:title)
    end

    it 'has images_by_title' do
      images_by_title = assigns[:images_by_title]
      animes = images_by_title.map(&:anime)
      expect(animes).to all have_attributes title: assigns[:title]
    end
  end
end
