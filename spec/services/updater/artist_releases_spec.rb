# frozen_string_literal: true

require 'rails_helper'

ReleaseData = Struct.new(:name, :id, :release_date, :images, :album_type)

RSpec.describe Updater::ArtistReleases do
  let(:artist) { create :artist }
  let(:release_1_title) { Faker::Music.album }
  let(:release_data1) do
    ReleaseData.new(
      release_1_title,
      'mock_id_1',
      '2020-01-01',
      [{ 'url' => 'some_url' }],
      'single'
    )
  end

  let(:release_data2) do
    ReleaseData.new(
      'mock_title',
      'mock_id_1',
      '2020-02-02',
      [{ 'url' => 'some_url' }],
      'single'
    )
  end
  let!(:release) { create :release, artist: artist, title: release_1_title }
  let(:artist_releases_updater) { described_class.new(artist) }
  let(:update) { artist_releases_updater.update!([release_data1, release_data2]) }

  describe '#update!' do
    it 'finds or initializes releases for the artist based on the data' do
      expect { update }.to change(Release, :count).by(1)
    end

    it 'updates a release found by title and artist_id' do
      update
      expect(release.reload.spotify_id).to eq(release_data2.id)
      expect(release.reload.release_type).to eq(release_data2.album_type)
    end
  end
end
