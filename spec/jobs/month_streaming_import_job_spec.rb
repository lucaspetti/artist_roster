# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonthStreamingImportJob, type: :job do
  let(:file_path) { Rails.root.join('spec', 'support', 'fixtures', 'timelines.csv') }
  let(:month_streaming_import) { build :month_streaming_import }

  before do
    month_streaming_import.file.attach(io: File.open(file_path), filename: 'timelines.csv')
    month_streaming_import.save
  end

  describe '#perform_later' do
    it 'uploads a backup' do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later(month_streaming_import.id) }.to have_enqueued_job
    end
  end

  describe 'job perform' do
    it 'runs the upload streaming service' do
      allow(Upload::Streaming).to receive(:run).with(
        month_streaming_import.file.download, month_streaming_import
      )
      described_class.perform_now(month_streaming_import.id)
      expect(month_streaming_import.reload.ran_at).not_to be_nil
    end
  end
end
