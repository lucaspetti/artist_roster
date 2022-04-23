# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Factory::MonthlyStreaming do
  subject { described_class.new(csv_row, streaming_import) }

  describe '#create' do
    let(:csv_row) do
      CSV::Row.new %w[date listeners streams followers], data
    end
    let(:monthly_streaming) { MonthlyStreaming.last }
    let(:streaming_import) { create :month_streaming_import }

    before { subject.create }

    context 'when it is not the last day of the month' do
      let(:data) { %w[2020-03-16 62 1095 111] }

      it 'creates an instance of a monthly streaming' do
        expect(MonthlyStreaming.count).to eq 1
      end

      it 'loads it with the correct data' do
        expect(monthly_streaming.streams).to eq 1095
        expect(monthly_streaming.listeners).to eq 62
        expect(monthly_streaming.followers).to eq 0
        expect(monthly_streaming.month_streaming_import).to eq streaming_import
      end
    end

    context 'when it is the last day of the month' do
      let(:data) { %w[2020-03-31 66 1300 111] }

      it 'creates an instance of a monthly streaming' do
        expect(MonthlyStreaming.count).to eq 1
      end

      it 'loads it with the correct data' do
        expect(monthly_streaming.streams).to eq 1300
        expect(monthly_streaming.listeners).to eq 66
        expect(monthly_streaming.followers).to eq 111
        expect(monthly_streaming.month_streaming_import).to eq streaming_import
      end
    end
  end
end
