# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Lorem.words.join(' ').capitalize }
    description { Faker::Lorem.sentence }

    trait :invalid do
      name { nil }
    end
  end
end
