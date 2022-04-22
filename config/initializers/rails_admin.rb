# frozen_string_literal: true

RailsAdmin.config do |config|
  config.main_app_name = ['Artist Roster']

  config.asset_source = :webpacker

  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  creatable = ['Artist', 'MonthStreamingImport', 'Playlist', 'PlaylistDataImport', 'Release']
  editable = ['Artist', 'Playlist', 'Release']

  config.actions do
    dashboard
    index
    show
    export

    new do
      only creatable
    end

    edit do
      only editable
    end

    bulk_delete do
      only creatable
    end

    delete do
      only creatable
    end
  end
end
