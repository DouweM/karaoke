require "karaoke/song/base"

module Karaoke
  module Song
    class Lyricsfreak < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("lyricsfreak.com")
      end

      def artist
        return @artist if defined?(@artist)

        el = document.css(%Q{a[data-tracking='\["Meta","Lyrics","ArtistName"\]']}).first
        return @artist = nil unless el

        @artist = el.text
      end

      def title
        return @title if defined?(@title)

        el = document.css(".song-info-panel h1").first
        return @title = nil unless el

        @title = el.text.match("^(.+?) Lyrics$")[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css("#content_h").first
        return @lyrics = nil unless el

        @lyrics = clean_html(el.inner_html)
      end
    end

    register_song_type Lyricsfreak
  end
end