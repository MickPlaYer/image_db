# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :image_by_id, only: %i[show clear]
  before_action :must_be_queried, only: %i[clear]

  def index
    permited_params = params.permit(:title, :page)
    conditions = permited_params.slice(:title)
    @images = Image.where(conditions)
                   .order(:id)
                   .page(params[:page])
                   .per(200)
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

  def must_be_queried
    return if @image.queried?

    redirect_to :show_image, flash: { error: t('.must_be_queried') }
  end
end
