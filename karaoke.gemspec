$:.push File.expand_path("../lib", __FILE__)
require "karaoke/version"

Gem::Specification.new do |s|
  s.name          = "karaoke"
  s.version       = Karaoke::VERSION

  s.platform      = Gem::Platform::RUBY
  s.author        = "Douwe Maan"
  s.email         = "douwe@selenight.nl"
  s.homepage      = "https://github.com/DouweM/karaoke"
  s.description   = "A Ruby library for easily finding the lyrics to your favorite songs"
  s.summary       = "Find lyrics to your favorite songs"
  s.license       = "MIT"

  s.files         = Dir.glob("lib/**/*") + %w(LICENSE README.md Rakefile Gemfile)
  s.test_files    = Dir.glob("spec/**/*")
  s.require_path  = "lib"
  
  s.add_dependency "nokogiri"
  s.add_dependency "google-search"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end