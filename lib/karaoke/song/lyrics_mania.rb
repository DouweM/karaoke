require "karaoke/song/base"

module Karaoke
  module Song
    class LyricsMania < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("lyricsmania.com")
      end

      def artist
        return @artist if defined?(@artist)

        el = document.css(".lyrics-nav hgroup h3").first
        return @artist = nil unless el

        @artist = el.text
      end

      def title
        return @title if defined?(@title)

        el = document.css(".lyrics-nav hgroup h2").first
        return @title = nil unless el

        @title = el.text.match("^(.+?) lyrics$")[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css(".lyrics-body").first || document.css(".lyrics .col-left").first
        return @lyrics = nil unless el

        el.css("div").remove
        el.css("strong").remove

        @lyrics = clean_html(el.inner_html)
      end
    end

    register_song_type LyricsMania
  end
end