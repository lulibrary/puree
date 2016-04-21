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
  spec.description   = %q{Consumes the Pure Research Information System API and facilitates post-processing of metadata into simple data structures.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httparty', '~> 0'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency 'rake', '~> 0'
end
