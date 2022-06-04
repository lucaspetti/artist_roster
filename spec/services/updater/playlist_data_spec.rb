# frozen_string_literal: true

require 'rails_helper'

PlaylistSpotifyData = Struct.new(:name, :id, :followers, :description)

RSpec.describe Updater::PlaylistData do
  let(:playlist) { create :playlist }
  let(:playlist_spotify_data) do
    PlaylistSpotifyData.new(
      playlist.name,
      'mock_id_1',
      { 'total' => 30 },
      'playlist description'
    )
  end

  let(:spotify_playlist_data_updater) { described_class.new(playlist_spotify_data) }
  let(:update) { spotify_playlist_data_updater.update! }

  describe '#update!' do
    context 'playlist not found' do
      it 'raises an error if playlist was not found' do
        playlist.delete
        expect { update }.to raise_error
      end

    end

    context 'playlist data not found' do
      it 'raises an error if playlist data was not found' do
        expect { update }.to raise_error('Playlist Data not found')
      end

    end

    context 'success' do
      let!(:playlist_data) { create :playlist_datum, playlist: playlist }

      it 'updates last playlist data found by name' do
        update
        expect(playlist.reload.spotify_id).to eq(playlist_spotify_data.id)
        expect(playlist.reload.description).to eq(playlist_spotify_data.description)
        expect(playlist_data.reload.followers).to eq(playlist_spotify_data.followers['total'])
      end
    end
  end
end
