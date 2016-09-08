# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puree/version'

Gem::Specification.new do |spec|
  spec.name          = "puree"
  spec.version       = Puree::VERSION
  spec.authors       = ["Adrian Albin-Clark"]
  spec.email         = ["a.albin-clark@lancaster.ac.uk"]
  spec.summary       = %q{A client for the Pure Research Information System API.}
  spec.description   = %q{Consumes the Pure Research Information System API and puts the metadata into simple data structures.}
  spec.homepage      = "https://aalbinclark.gitbooks.io/puree"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.1'

  spec.add_runtime_dependency 'http', '~> 2.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
end
