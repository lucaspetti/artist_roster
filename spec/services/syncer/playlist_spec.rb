# frozen_string_literal: true

require 'rails_helper'

PlaylistOwner = Struct.new(:display_name)

RSpec.describe Syncer::Playlist do
  let(:playlist) { create :playlist }
  let(:playlist_spotify_data) do
    PlaylistSpotifyData.new(
      playlist.name,
      'mock_id_1',
      { 'total' => 30 },
      'playlist description',
      PlaylistOwner.new(playlist.author)
    )
  end

  let(:playlist_syncer) { described_class.new }

  describe '#sync_playlists' do
    before { Timecop.freeze(Time.local(2020, 9, 1, 12, 0, 0)) }

    let(:sync_playlists) { playlist_syncer.sync_playlists }
    let!(:playlist_datum) do
      create :playlist_datum, playlist: playlist, month: 8, year: 2020
    end

    context 'when playlist has no spotify_id and author is spotify' do
      before do
        playlist.update!(author: 'Spotify', spotify_id: nil)
      end

      it 'skips the given playlist' do
        expect { sync_playlists }.not_to raise_error
      end
    end

    context 'when playlist has no spotify_id' do

      before do
        playlist.update!(author: 'Someone', spotify_id: nil)
        expect(RSpotify::Playlist).to receive(:search).with(playlist.name).and_return([playlist_spotify_data])
      end

      it 'calls the search on client and filters by name and author' do
        expect { sync_playlists }.to_not raise_error
        expect(playlist.reload.spotify_id).to eq(playlist_spotify_data.id)
        expect(playlist.reload.description).to eq(playlist_spotify_data.description)
        expect(playlist_datum.reload.followers).to eq(playlist_spotify_data.followers['total'])
      end
    end

    context 'when playlist has a spotify_id' do
      before do
        playlist.update!(spotify_id: playlist_spotify_data.id)
        expect(RSpotify::Playlist).to receive(:find).with(playlist.author, playlist.spotify_id)
          .and_return(playlist_spotify_data)
      end

      it 'calls find on client by spotify_id' do
        expect { sync_playlists }.to_not raise_error
        expect(playlist.reload.spotify_id).to eq(playlist_spotify_data.id)
        expect(playlist.reload.description).to eq(playlist_spotify_data.description)
        expect(playlist_datum.reload.followers).to eq(playlist_spotify_data.followers['total'])
      end
    end

    context 'when data is not found for given playlist' do
      before do
        playlist.update!(spotify_id: playlist_spotify_data.id)
        expect(RSpotify::Playlist).to receive(:find).with(playlist.author, playlist.spotify_id)
          .and_return(nil)
      end

      it 'skips to next record' do
        expect { sync_playlists }.to_not raise_error
      end
    end
  end
end
