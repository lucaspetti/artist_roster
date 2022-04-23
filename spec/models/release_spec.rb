# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Release, type: :model do
  it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:release_type).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:spotify_id).of_type(:string) }
  it { is_expected.to have_db_column(:image_url).of_type(:string) }
  it { is_expected.to have_db_column(:released_at).of_type(:datetime) }
  it { is_expected.to belong_to(:artist) }

  it { is_expected.to validate_presence_of(:release_type) }
  it { is_expected.to validate_presence_of(:title) }
end
