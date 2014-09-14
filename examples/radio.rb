#!/usr/bin/env ruby

# This script listens to the specified radio stream and prints the lyrics for the song that's currently playing.

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

  song = Karaoke.search(metadata.now_playing)
  if song
    puts "Lyrics from #{song.lyrics_url}:"
    puts song.lyrics
  else
    puts "Lyrics not found."
  end

  puts
  puts
end

trap("INT") { stream.disconnect }
stream.listen