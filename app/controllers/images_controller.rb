# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :image_by_id, only: %i[show clear]

  def index
    conditions = params.permit(:title)
    @images = Image.where(conditions)
                   .order(:file_name)
                   .page(params[:page])
                   .per(100)
  end

  def show; end

  def clear
    @image.update!(title: nil, season: nil, episode: nil)
    redirect_to :show_image
  end

  private

  def image_by_id
    @image = Image.find(params[:id])
  end
end
