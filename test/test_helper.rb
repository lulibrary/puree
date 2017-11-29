require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib)

require 'puree'
require 'purification'

def config
  {
      url:      ENV['PURE_URL_TEST_59'],
      username: ENV['PURE_USERNAME'],
      password: ENV['PURE_PASSWORD'],
      api_key:  ENV['PURE_API_KEY']
  }
end

def asserts_resource(x)
  assert_instance_of Time, x.created_at

  assert_instance_of String, x.created_by

  assert_instance_of Time, x.modified_at

  assert_instance_of String, x.modified_by

  assert_instance_of String, x.uuid
end
