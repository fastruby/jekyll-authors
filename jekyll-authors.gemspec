# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jekyll-authors/version"

Gem::Specification.new do |s|
  s.name        = "jekyll-authors"
  s.version     = Jekyll::Authors::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mauro Otonelli", "Ernesto Tagwerker"]
  s.email       = ["mauro@ombulabs.com", "ernesto@ombulabs.com"]
  s.homepage    = "http://github.com/ombulabs/jekyll-authors"
  s.summary     = %q{Author generators for Jekyll}
  s.description = %q{Provides an author index page and author atom feeds for Jekyll.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('jekyll', [">= 0.10.0"])
end
