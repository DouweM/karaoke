#!/usr/bin/env ruby

# This script listens to the specified audio stream and prints the song's lyrics.

require "karaoke"
require "shoutout"

unless ARGV[0]
  STDERR.puts "Usage: radio.rb [STREAM URL]"
  exit 1
end

stream = Shoutout::Stream.new(ARGV[0])

stream.connect

puts "Listening to #{stream.name}"

stream.metadata_change do |metadata|
  puts "Now playing: #{metadata.now_playing}"
  puts

  lyrics = Karaoke.lyrics(metadata.now_playing)
  puts lyrics || "Lyrics not found."

  puts
  puts
end

trap("INT") { stream.disconnect }
stream.listen