# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Playlist, type: :model do
  let(:playlist) { create(:playlist) }

  it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:author).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:mood).of_type(:string) }
  it { is_expected.to have_db_column(:genre).of_type(:string) }
  it { is_expected.to have_db_column(:spotify_id).of_type(:string) }
  it { is_expected.to have_db_column(:description).of_type(:text) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:author) }
end
