# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Upload::PlaylistData do
  describe '#valid_file?' do
    subject { described_class.valid_file?(file) }

    context 'when the file is a valid comma separated' do
      let(:file) { load_fixture_file('playlists-28day.csv') }

      it { is_expected.to be_truthy }
    end

    context 'when the file is not a valid csv' do
      let(:file) { load_fixture_file('timelines.json') }

      it { is_expected.to be_falsey }
    end
  end

  describe '#run' do
    context 'when the file is a valid and the month does not exist for artist' do
      let(:file) { load_fixture_file('playlists-28day.csv') }
      let(:playlist_data_import) { create :playlist_data_import }
      let(:service) { described_class.run(file, playlist_data_import) }
      let(:created_playlist_data) { PlaylistDatum.first }

      it 'creates the month for artist' do
        expect { service }.to change(PlaylistDatum, :count).by(5)
      end

      it 'assigns the correct data for all playlist data' do
        service
        expect(created_playlist_data.month).to eq(playlist_data_import.month)
        expect(created_playlist_data.year).to eq(playlist_data_import.year)
        expect(created_playlist_data.artist_id).to eq(playlist_data_import.artist_id)
      end
    end
  end
end
