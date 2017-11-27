# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puree/version'

Gem::Specification.new do |spec|
  spec.name          = 'puree'
  spec.version       = Puree::VERSION
  spec.authors       = 'Adrian Albin-Clark'
  spec.email         = 'a.albin-clark@lancaster.ac.uk'
  spec.summary       = %q{Metadata extraction from the Pure Research Information System.}
  spec.homepage      = 'https://github.com/lulibrary/puree'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.1'

  spec.add_runtime_dependency 'http', '~> 3.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'

  spec.add_development_dependency 'rspec'
end
