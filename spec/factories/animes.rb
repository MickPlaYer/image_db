# frozen_string_literal: true

FactoryBot.define do
  factory :anime do
    trait :bakemonogatari do
      title { '化物語' }
      season { '2009-07' }
    end

    trait :toradora do
      title { 'とらドラ！' }
      season { '2008-10' }
    end
  end
end
