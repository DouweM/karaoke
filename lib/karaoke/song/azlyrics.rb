require "karaoke/song/base"

module Karaoke
  module Song
    class Azlyrics < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("azlyrics.com")
      end

      def artist
        return @artist if defined?(@artist)

        @artist = data.match(/ArtistName = "([^"]+)";/)[1]
      end

      def title
        return @title if defined?(@title)

        @title = data.match(/SongName = "([^"]+)";/)[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css("div[style='margin-left:10px;margin-right:10px;']").first
        return @lyrics = nil unless el

        el.css("i").each { |i_el| i_el.replace(i_el.inner_html) }

        lyrics = clean_html(el.inner_html)
        lyrics.gsub!("<!-- start of lyrics -->", "")
        lyrics.gsub!("<!-- end of lyrics -->", "")
        @lyrics = lyrics
      end
    end

    register_song_type Azlyrics
  end
end