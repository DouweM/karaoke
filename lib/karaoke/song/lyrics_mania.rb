require "karaoke/song/base"

module Karaoke
  module Song
    class LyricsMania < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("lyricsmania.com")
      end

      def artist
        return @artist if defined?(@artist)

        @artist = data.match(/cf_page_artist = "([^"]+)";/)[1]
      end

      def title
        return @title if defined?(@title)

        @title = data.match(/cf_page_song = "([^"]+)";/)[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css(".lyrics-body").first
        return @lyrics = nil unless el

        el.css("div").remove
        el.css("strong").remove

        @lyrics = clean_html(el.inner_html)
      end
    end

    register_song_type LyricsMania
  end
end