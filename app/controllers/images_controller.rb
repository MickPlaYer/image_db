# frozen_string_literal: true

class ImagesController < ApplicationController
  def index
    conditions = params.permit(:title)
    @images = Image.where(conditions)
                   .order(:file_name)
                   .page(params[:page])
                   .per(100)
  end
end