# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaylistDataImportJob, type: :job do
  let(:file_path) { Rails.root.join('spec', 'support', 'fixtures', 'playlists-28day.csv') }
  let(:playlist_data_import) { build :playlist_data_import }

  before do
    playlist_data_import.file.attach(io: File.open(file_path), filename: 'playlists-28day.csv')
    playlist_data_import.save
  end

  describe '#perform_later' do
    it 'uploads a backup' do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later(playlist_data_import.id) }.to have_enqueued_job
    end
  end

  describe 'job perform' do
    it 'runs the upload streaming service' do
      allow(Upload::PlaylistData).to receive(:run).with(
        playlist_data_import.file.download, playlist_data_import
      )
      described_class.perform_now(playlist_data_import.id)
      expect(playlist_data_import.reload.ran_at).not_to be_nil
    end
  end
end
