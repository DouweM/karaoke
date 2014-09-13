# karaoke

A Ruby library for easily finding the lyrics to your favorite songs.

## Installation

```sh
gem install karaoke
```

Or in your Gemfile:

```ruby
gem "karaoke"
```

## Usage

```ruby
require "karaoke"

# To find the lyrics to a song, simply search for it:
song = Karaoke.search("Armin van Buuren - This Is What It Feels Like")
# Be as creative as you want, karaoke usually knows what you're looking for:
song = Karaoke.search("This Is What It Feels Like - Armin van Buuren")
song = Karaoke.search("This Is What It Feels Like by Armin van Buuren")
song = Karaoke.search("Song by Armin van Buuren with vocals by Trevor Guthrie")

# This will return a Song object containing the following information:
song.artist # => "Armin van Buuren"
song.title  # => "This Is What It Feels Like"
song.lyrics # => "Nobody here knocking at my door\n" and so on.

# If you're only interested in the lyrics, save a couple of keystrokes:
lyrics = Karaoke.lyrics("Armin van Buuren - This Is What It Feels Like") 
# => "Nobody here knocking at my door\n" and so on.

# Behind the scenes, karaoke searches Google to find results on any of these sites:
# (Rap)Genius, MetroLyrics, Lyricsfreak, AZLyrics, DirectLyrics and LyricsMania
# Next, karaoke reads the lyrics from the highest ranked Google search result.

# If, for whatever reason, you want access to all of the found lyrics
# instead of just the highest ranked one, use `Karaoke::Search` directly:
Karaoke::Search.new("Armin van Buuren - This Is What It Feels Like").results
# => [
#   #<Karaoke::Song::Azlyrics:0x007fef3a080b98>, 
#   #<Karaoke::Song::MetroLyrics:0x007fef3c01c9c0>, 
#   #<Karaoke::Song::Genius:0x007fef3a0cf900>, 
#   #<Karaoke::Song::LyricsMania:0x007fef3a0d1a98>
# ]
```

## Examples
Check out the [`examples/`](examples) folder for an example that I actually use myself.

## License
Copyright (c) 2014 Douwe Maan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.