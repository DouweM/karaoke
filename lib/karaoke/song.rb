module Karaoke
  module Song
    class << self
      @@services = []
      
      def register_song_type(song_type)
        @@services |= [song_type]
      end

      def song_type_for(lyrics_uri)
        @@services.find { |song_type| song_type.matches?(lyrics_uri) }
      end
    end
  end
end

require "karaoke/song/genius"
require "karaoke/song/metro_lyrics"
require "karaoke/song/lyricsfreak"
# require "karaoke/song/lyricsmode"
require "karaoke/song/azlyrics"
require "karaoke/song/directlyrics"
require "karaoke/song/lyrics_mania"
require "karaoke/song/limitless_lyrics"