# frozen_string_literal: true

class Image < ApplicationRecord
  validates :file_name, presence: true

  enum queried: { queried: true, not_queried: false }

  def self.search(query)
    queries = query.to_s.strip.split(' ').map { |e| "#{sanitize_sql_like(e)}%" }
    ransack(
      file_name_matches_any: queries,
      title_matches_any: queries,
      m: 'or'
    ).result
  end

  def basename
    File.basename(file_name, '.*')
  end
end
