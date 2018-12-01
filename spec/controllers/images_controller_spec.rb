# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  describe '#index' do
    let!(:images) do
      [
        create(:image, :bakemonogatari),
        create(:image, :toradora)
      ]
    end

    before { get :index }

    it { expect(response).to have_http_status(:ok) }
    it 'has images' do
      expect(assigns[:images]).to eq images
    end

    context 'when filter by param title' do
      before { get :index, params: { title: images.first.title } }

      it { expect(response).to have_http_status(:ok) }
      it 'has filtered images' do
        expect(assigns[:images]).to eq [images.first]
      end
    end
  end
end
