# frozen_string_literal: true

FactoryBot.define do
  factory :month_streaming_import do
    file { fixture_file_upload(::Rails.root.join('spec', 'support', 'fixtures', 'timelines.csv')) }
    artist
  end
end
