# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def homepage
    @images = Image.includes(:anime)
                   .queried.order(:updated_at)
                   .reverse_order
                   .limit(10)
    @titles = Anime.distinct(:title).pluck(:title)
    @title = @titles.sample
    @images_by_title = Image.includes(:anime)
                            .where(animes: { title: @title })
                            .limit(10)
  end
end
