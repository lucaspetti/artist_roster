# frozen_string_literal: true

FactoryBot.define do
  factory :playlist_data_import do
    file { fixture_file_upload(::Rails.root.join('spec', 'support', 'fixtures', 'playlists-28day.csv')) }
    artist
    month { 1 }
    year { 1 }
    user
  end
end
