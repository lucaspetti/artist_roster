# frozen_string_literal: true

require 'rails_helper'

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
    before { Timecop.freeze(Time.local(2020, 9, 1, 12, 0, 0)) }

    context 'playlist not found' do
      it 'raises an error if playlist was not found' do
        playlist.delete
        expect { update }.to raise_error
      end

    end

    context 'success' do
      let!(:playlist_data) do
        create :playlist_datum, playlist: playlist, month: 8, year: 2020
      end

      it 'updates last months playlist data found by name' do
        update
        expect(playlist.reload.spotify_id).to eq(playlist_spotify_data.id)
        expect(playlist.reload.description).to eq(playlist_spotify_data.description)
        expect(playlist_data.reload.followers).to eq(playlist_spotify_data.followers['total'])
      end
    end
  end
end
