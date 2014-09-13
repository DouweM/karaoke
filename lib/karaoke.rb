require "karaoke/version"
require "karaoke/search"

module Karaoke
  class << self
    def search(query)
      Search.new(query).results.first
    end

    def lyrics(query)
      song = search(query)

      song && song.lyrics
    end
  end
end