require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib)

require 'puree'

def config
  {
      url:      ENV['PURE_URL_TEST_59'],
      username: ENV['PURE_USERNAME'],
      password: ENV['PURE_PASSWORD'],
      api_key:  ENV['PURE_API_KEY']
  }
end