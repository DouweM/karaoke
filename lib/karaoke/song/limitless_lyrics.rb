require "karaoke/song/base"

module Karaoke
  module Song
    class LimitlessLyrics < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("limitlesslyrics.com")
      end

      def artist
        return @artist if defined?(@artist)

        el = document.css("h1").first || document.css("h2").first
        return @artist = nil unless el

        @artist = el.text.split(" - ", 2)[0]
      end

      def title
        return @title if defined?(@title)

        el = document.css("h1").first || document.css("h2").first
        return @title = nil unless el

        @title = el.text.split(" - ", 2)[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css("#botmid2").first
        return @lyrics = nil unless el

        @lyrics = clean_html(el.css("p").inner_html)
      end
    end

    register_song_type LimitlessLyrics
  end
end