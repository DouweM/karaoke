require "net/http"
require "uri"
require "nokogiri"

module Karaoke
  module Song
    class Base
      attr_reader :lyrics_url

      def initialize(lyrics_url)
        @lyrics_url = lyrics_url
      end

      def artist
        raise NotImplementedError.new("The Song::Base subclass needs to override the #artist method.")
      end

      def title
        raise NotImplementedError.new("The Song::Base subclass needs to override the #title method.")
      end

      def lyrics
        raise NotImplementedError.new("The Song::Base subclass needs to override the #lyrics method.")
      end

      private
        def data
          @data ||= begin
            redirects = 0
            begin
              raise "Too many redirects" if redirects == 5

              uri         = URI.parse(@lyrics_url)
              connection  = Net::HTTP.new(uri.host, uri.port)
              connection.use_ssl = uri.is_a?(URI::HTTPS)
              
              request = Net::HTTP::Get.new(uri.request_uri)
              response = connection.request(request)

              redirects += 1
            end while response.is_a?(Net::HTTPRedirection) && @lyrics_url = response["location"]

            response.body
          end
        end

        def document
          @document ||= Nokogiri::HTML::Document.parse(data)
        end

        def clean_html(html)
          html.gsub(/[\t\n\r]/, "").gsub("<br>", "\n")
        end
    end
  end
end