# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :filter_images, only: %i[index search]
  before_action :image_by_id, only: %i[show clear]
  before_action :must_be_queried, only: %i[clear]

  def index
    @images = @images.order(:id).page(params[:page]).per(200)
  end

  def show; end

  def search
    if @images.count == 1
      @image = @images.first
      redirect_to show_image_path(@image.id)
    else
      redirect_to images_path(search: params[:search])
    end
  end

  def clear
    @image.update!(title: nil, season: nil, episode: nil)
    redirect_to :show_image
  end

  private

  def image_by_id
    @image = Image.find(params[:id])
  end

  def filter_images
    conditions = params.permit(:title)
    @images = Image.where(conditions)
    @images = @images.search(params[:search]) if params[:search].present?
  end

  def must_be_queried
    return if @image.queried?

    redirect_to :show_image, flash: { error: t('.must_be_queried') }
  end
end
