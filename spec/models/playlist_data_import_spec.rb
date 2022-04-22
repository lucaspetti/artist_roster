# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaylistDataImport, type: :model do
  it { is_expected.to have_db_column(:file).of_type(:string) }
  it { is_expected.to have_db_column(:ran_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:month).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:year).of_type(:integer).with_options(null: false) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:artist) }
end
