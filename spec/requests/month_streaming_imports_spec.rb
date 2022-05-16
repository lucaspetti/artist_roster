# frozen_string_literal: true

require 'json_web_token'
require 'rails_helper'

RSpec.describe 'Month Streaming Imports Request', type: :request do
  let(:user) { create(:user) }
  let(:token) do
    JsonWebToken.encode({ email: user.email })
  end
  let(:headers) do
    { Authorization: token }
  end
  let(:artist) { create(:artist) }
  let(:filepath) { "#{Rails.root}/spec/support/fixtures/timelines.csv" }

  let(:params) do
    {
      file: Rack::Test::UploadedFile.new(filepath, 'text/csv'),
      artist_id: artist.id
    }
  end

  it 'creates a month streaming import' do
    expect do
      post api_v1_month_streaming_imports_path, params: params, headers: headers
    end.to change(MonthStreamingImport, :count).by(1)
  end
end
