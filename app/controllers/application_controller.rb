# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def homepage
    @images = Image.queried.order(:updated_at).last(10)
    @titles = Image.where.not(title: nil).distinct(:title).pluck(:title)
    @title = @titles.sample
    @images_by_title = Image.where(title: @title).limit(10)
  end
end
