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

  describe '#clear' do
    let(:image) { create(:image, :bakemonogatari) }

    before { put :clear, params: { id: image.id } }

    it { expect(response).to redirect_to(:show_image) }
    it 'clear image data' do
      image.reload
      expect(image).to have_attributes(title: nil,
                                       season: nil,
                                       episode: nil)
    end
  end

  describe '#query_all' do
    after { clear_enqueued_jobs }

    it { expect { post :query_all }.to have_enqueued_job }

    describe 'result' do
      before { post :query_all }

      it { expect(Images::QueryAllJob).to have_been_enqueued }
      it { expect(response).to have_http_status :ok }
    end
  end
end
