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
  spec.metadata = {
    'source_code_uri' => "https://github.com/lulibrary/#{spec.name}",
    "documentation_uri" => "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
  }
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'http', '~> 5.1'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'

  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
end
