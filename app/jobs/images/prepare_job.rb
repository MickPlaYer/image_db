# frozen_string_literal: true

module Images
  class PrepareJob < ApplicationJob
    ACTIONS = %w[thumb].freeze

    queue_as :default

    def initialize(*arguments)
      super
      others = arguments - ACTIONS
      return if others.blank?

      raise ArgumentError, "Actions can not include: #{others.join(', ')}. " \
                           "Only allow: #{ACTIONS.join(', ')}."
    end

    def perform(*_args)
      file_paths = Dir.glob(ImageDb.images_path.join('*'))
      file_paths.each_slice(100) do |paths|
        file_names = paths.map { |path| File.basename(path) }
        image_file_names = Image.where(file_name: file_names).pluck(:file_name)
        images = (file_names - image_file_names).map do |file_name|
          image = Image.new(file_name: file_name)
          thumb_image(image) if thumb?
          image
        end
        Image.import images
      end
    end

    private

    def method_missing(method_name)
      action = method_name.to_s[0...-1]
      return action.in?(@arguments) if respond_to_missing?(method_name)

      super
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name = method_name.to_s
      action = method_name[0...-1]
      (method_name.end_with?('?') && action.in?(ACTIONS)) || super
    end
  end
end
