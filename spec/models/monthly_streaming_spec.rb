# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonthlyStreaming, type: :model do
  it { is_expected.to belong_to(:month_streaming_import) }

  it { is_expected.to have_db_column(:month).of_type(:integer) }
  it { is_expected.to have_db_column(:year).of_type(:integer) }
  it { is_expected.to have_db_column(:streams).of_type(:integer) }
  it { is_expected.to have_db_column(:listeners).of_type(:integer) }
  it { is_expected.to have_db_column(:followers).of_type(:integer) }
end
