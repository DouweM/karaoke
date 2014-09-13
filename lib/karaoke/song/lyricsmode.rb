require "karaoke/song/base"

# Doesn't work, because Lyricsmode blocks access from bots with 403 Forbidden.

module Karaoke
  module Song
    class Lyricsmode < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("lyricsmode.com")
      end

      def artist
        return @artist if defined?(@artist)

        el = document.css(%Q{a[data-tracking='\["Meta","Lyrics","ArtistName"\]']}).first
        return @artist = nil unless el

        @artist = el.text
      end

      def title
        return @title if defined?(@title)

        el = document.css("h1.song_name").first
        return @title = nil unless el

        @title = el.text.trim.match("^(.+?) Lyrics$")[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css(".meaning_inside_frame").first
        return @lyrics = nil unless el

        @lyrics = clean_html(el.inner_html)
      end
    end

    register_song_type Lyricsmode
  end
end