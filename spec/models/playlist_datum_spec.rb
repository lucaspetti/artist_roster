# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaylistDatum, type: :model do
  it { is_expected.to have_db_column(:month).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:year).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:streams).of_type(:integer) }
  it { is_expected.to have_db_column(:listeners).of_type(:integer) }

  it { is_expected.to belong_to(:playlist) }
  it { is_expected.to belong_to(:artist) }
end
