# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    queried { true }
    trait :bakemonogatari do
      file_name { '1543697758.jpg' }
      association :anime, factory: %i[anime bakemonogatari]
      episode { '1' }
    end

    trait :toradora do
      file_name { '1543698679.jpg' }
      association :anime, factory: %i[anime toradora]
      episode { '1' }
    end
  end
end
