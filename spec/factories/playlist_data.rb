# frozen_string_literal: true

FactoryBot.define do
  factory :playlist_datum do
    playlist
    artist
    month { 1 }
    year { 1 }
    streams { 1 }
    listeners { 1 }
    followers { 1 }
  end
end
