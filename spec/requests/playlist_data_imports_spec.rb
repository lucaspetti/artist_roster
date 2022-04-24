# frozen_string_literal: true

require 'json_web_token'
require 'rails_helper'

RSpec.describe 'Playlist Data Imports Request', type: :request do
  let(:user) { create(:user) }
  let(:token) do
    JsonWebToken.encode({ email: user.email })
  end
  let(:headers) do
    { Authorization: token }
  end
  let(:artist) { create(:artist) }
  let(:filepath) { "#{Rails.root}/spec/support/fixtures/playlists-28day.csv" }

  let(:params) do
    {
      file: Rack::Test::UploadedFile.new(filepath, 'text/csv'),
      artist_id: artist.id,
      month: 1,
      year: 2000
    }
  end

  it 'creates a playlist data import' do
    expect do
      post api_v1_playlist_data_imports_path, params: params, headers: headers
    end.to change(PlaylistDataImport, :count).by(1)
  end
end
