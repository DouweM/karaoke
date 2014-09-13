require "karaoke/song/base"

module Karaoke
  module Song
    class Genius < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("genius.com") # Matches new *.genius.com URLs as well as rapgenius.com.
      end

      def artist
        @artist ||= tracking_data["Primary Artist"] || tracking_data["Primary Arist"]
      end 

      def title
        @title ||= tracking_data["Title"]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css(".lyrics p").first
        return @lyrics = nil unless el

        el.css("a").each { |a_el| a_el.replace(a_el.inner_html) }

        @lyrics = clean_html(el.inner_html)
      end

      private
        def tracking_data
          @tracking_data ||= JSON.parse(data.match("var TRACKING_DATA = (\{.+?\})")[1])
        end
    end

    register_song_type Genius
  end
end