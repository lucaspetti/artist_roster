# frozen_string_literal: true

PlaylistSpotifyData = Struct.new(:name, :id, :followers, :description, :owner)

module RSpec
  module ServiceHelpers
    def load_fixture_file(filename)
      File.read(::Rails.root.join('spec', 'support', 'fixtures', filename))
    end
  end
end
