# frozen_string_literal: true

module RSpec
  module ServiceHelpers
    def load_fixture_file(filename)
      File.read(::Rails.root.join('spec', 'support', 'fixtures', filename))
    end
  end
end
