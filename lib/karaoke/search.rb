require "google-search"

require "karaoke/song"

module Karaoke
  class Search
    attr_reader :query

    def initialize(query)
      @query = query
    end

    def search_query
      "#{self.query} lyrics"
    end

    def results
      @results ||= begin
        song_results = []

        search_results = Google::Search::Web.new(query: search_query)
        search_results.each do |result|
          klass = Song.song_type_for(result.uri)
          next unless klass

          song_results << klass.new(result.uri)
        end

        song_results
      end
    end
  end
end