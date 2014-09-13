require "karaoke/song/base"

module Karaoke
  module Song
    class Directlyrics < Base
      def self.matches?(lyrics_url)
        URI.parse(lyrics_url).host.end_with?("directlyrics.com")
      end

      def artist
        return @artist if defined?(@artist)

        el = document.css(".breadcrumb a[href$='-artist.html']").first ||
          document.css("#hd-bar a[href$='-artist.html']").first
          
        return @artist = nil unless el

        @artist = el.text
      end

      def title
        return @title if defined?(@title)

        el = document.css(".hd h1").first || document.css("#hd h1").first
        return @title = nil unless el

        @title = el.text.match("^[^-]+- (.+?) lyrics$")[1]
      end

      def lyrics
        return @lyrics if defined?(@lyrics)

        el = document.css(".lyrics p").first || begin
          lyrics_class = data.match(/\$\('\.([a-z0-9]+)'\)\.addClass\('lyrics'\);/)[1]
          document.css("[class='#{lyrics_class}'] p").first
        end

        return @lyrics = nil unless el

        el.css("ins").remove

        @lyrics = clean_html(el.inner_html)
      end
    end

    register_song_type Directlyrics
  end
end