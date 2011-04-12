# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "no_phone/version"

Gem::Specification.new do |s|
  s.name        = "no_phone"
  s.version     = NoPhone::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Simen Svale Skogsrud, Katrina Owen"]
  s.email       = ["katrina@bengler.no"]
  s.homepage    = "http://rubygems.org/gems/no_phone"
  s.summary     = %q{Norwegian phone number scrubber}
  s.description = %q{Standardizes norwegian phone numbers, and leaves international numbers unchanged.}

  s.rubyforge_project = "no_phone"

  s.add_development_dependency('rspec')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
