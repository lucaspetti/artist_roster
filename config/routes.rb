# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'rails_admin/main#dashboard'

  namespace :api do
    namespace :v1 do
      post 'playlist_data_imports', to: 'playlist_data_imports#create'
      post 'month_streaming_imports', to: 'month_streaming_imports#create'
    end
  end
end
