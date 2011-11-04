# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "norwegian_phone/version"

Gem::Specification.new do |s|
  s.name        = "norwegian_phone"
  s.version     = NorwegianPhone::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Simen Svale Skogsrud, Katrina Owen"]
  s.email       = ["katrina@bengler.no"]
  s.homepage    = "http://rubygems.org/gems/norwegian_phone"
  s.summary     = %q{Norwegian phone number scrubber}
  s.description = %q{Standardizes norwegian phone numbers, and leaves international numbers unchanged.}

  s.rubyforge_project = "norwegian_phone"

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rspec-extra-formatters')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('simplecov-rcov')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
