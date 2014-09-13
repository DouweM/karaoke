require "karaoke/song/base"

module Karaoke
  module Song
    class MetroLyrics < Base
      def self.matches?(lyrics_url)
        uri = URI.parse(lyrics_url)

        uri.host.end_with?("metrolyrics.com") && !uri.path.end_with?("-lyrics.html")
      end

      def artist
        @artist ||= tracking_data["musicArtistName"]
      end 

      def title
        @title ||= tracking_data["musicSongTitle"]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css("#lyrics-body-text").first
        return @lyrics = nil unless el

        lyrics = clean_html(el.inner_html)
        lyrics.gsub!("</p><p class=\"verse\">", "\n\n")
        lyrics.gsub!("<p class=\"verse\">", "")
        lyrics.gsub!("</p>", "")
        @lyrics = lyrics
      end

      private
        def tracking_data
          @tracking_data ||= JSON.parse(data.match("var utag_data=(\{.+?\})")[1])
        end
    end

    register_song_type MetroLyrics
  end
end