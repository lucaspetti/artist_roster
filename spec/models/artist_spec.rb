# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject { create :artist }

  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:followers).of_type(:integer) }
  it { is_expected.to have_db_column(:popularity).of_type(:integer) }
  it { is_expected.to have_db_column(:spotify_id).of_type(:string) }
end
