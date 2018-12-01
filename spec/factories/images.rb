# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    queried { true }
    trait :bakemonogatari do
      file_name { '1543697758.jpg' }
      title { '化物語' }
      season { '2009-07' }
      episode { '1' }
    end

    trait :toradora do
      file_name { '1543698679.jpg' }
      title { 'とらドラ！' }
      season { '2008-10' }
      episode { '1' }
    end
  end
end
