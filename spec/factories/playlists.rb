# frozen_string_literal: true

FactoryBot.define do
  factory :playlist do
    name { 'Instrumental music' }
    mood { 'Relaxing' }
    genre { Faker::BossaNova.song }
    description { 'A relaxing instrumental playlist' }
    image { 'image.jpg' }
    author { 'Someone' }
  end
end
