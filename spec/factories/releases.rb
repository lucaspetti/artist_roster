# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    released_at { '2022-01-01 22:12:40' }
    artist
    image_url { 'MyString' }
    title { Faker::Music.album }
    release_type { 'Album' }
  end
end
