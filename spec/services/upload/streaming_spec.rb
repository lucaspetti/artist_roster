# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Upload::Streaming do
  describe '#valid_file?' do
    subject { described_class.valid_file?(file) }

    context 'when the file is a valid comma separated' do
      let(:file) { load_fixture_file('timelines.csv') }

      it { is_expected.to be_truthy }
    end

    context 'when the file is a valid semicolon separated' do
      let(:file) { load_fixture_file('timelines_semicolon.csv') }

      it { is_expected.to be_truthy }
    end

    context 'when the file is not a valid csv' do
      let(:file) { load_fixture_file('timelines.json') }

      it { is_expected.to be_falsey }
    end
  end

  describe '#run' do
    context 'when the file is a valid and the month does not exist for artist' do
      let(:file) { load_fixture_file('timelines.csv') }
      let(:streaming_import) { create :month_streaming_import }

      it 'creates the month for artist' do
        expect do
          described_class.run(file, streaming_import)
        end.to change(MonthlyStreaming, :count).by(9)
      end
    end
  end
end
