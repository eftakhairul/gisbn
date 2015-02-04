# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gisbn/version'

Gem::Specification.new do |spec|
  spec.name          = "gisbn"
  spec.version       = Gisbn::VERSION
  spec.authors       = ["Eftakhairul Islam"]
  spec.email         = ["eftakhairul@gmail.com"]
  spec.summary       = %q{Book information from ISBN by Google Book API.}
  spec.description   = %q{It fetches book's information by ISBN number based on Google Book API.}
  spec.homepage      = "https://github.com/eftakhairul/gisbn"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
