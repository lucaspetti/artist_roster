# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Factory::PlaylistData do
  subject { described_class.new(csv_row, playlist_data_import) }

  describe '#create' do
    let(:csv_row) do
      CSV::Row.new %w[title author listeners streams date_added], data
    end
    let(:playlist_data) { PlaylistDatum.last }
    let(:playlist_data_import) { create :playlist_data_import }

    context 'when playlist is not already created' do
      let(:data) { %w[World_Music NovaSonora 93 200 2019-07-28] }

      it 'creates an instance of a playlist' do
        expect { subject.create }.to change(Playlist, :count).by(1)
      end

      it 'created an instance of a playlist_data' do
        expect { subject.create }.to change(PlaylistDatum, :count).by(1)
      end

      it 'loads it with the correct data' do
        subject.create
        expect(playlist_data.streams).to eq 200
        expect(playlist_data.listeners).to eq 93
        expect(playlist_data.artist_id).to eq playlist_data_import.artist_id
      end
    end

    context 'when playlist is already created' do
      let!(:playlist) { create :playlist, name: 'World_Music', author: 'NovaSonora' }
      let(:data) { %w[World_Music NovaSonora 100 300 2019-07-28] }

      it 'does not create a new instance of a playlist' do
        expect { subject.create }.not_to change(Playlist, :count)
      end

      it 'created an instance of a playlist_data' do
        expect { subject.create }.to change(PlaylistDatum, :count).by(1)
      end

      it 'loads it with the correct data' do
        subject.create
        expect(playlist_data.streams).to eq 300
        expect(playlist_data.listeners).to eq 100
        expect(playlist_data.artist_id).to eq playlist_data_import.artist_id
      end
    end
  end
end
