# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.not_to allow_value('blah').for(:email) }
  it { is_expected.to allow_value('a@b.com').for(:email) }
end
