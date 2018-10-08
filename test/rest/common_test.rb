require 'test_rest_helper'

class TestResourceCommon < Minitest::Test

  # all
  resources.each do |resource|
    test_name = "test_#{resource}_all"
    define_method(test_name) do
      # puts test_name
      response = resource_instance(resource).all
      # puts response
      assert_instance_of HTTP::Response, response
    end
  end

  # all_complex
  resources.each do |resource|
    test_name = "test_#{resource}_all_complex"
    define_method(test_name) do
      # puts test_name
      response = resource_instance(resource).all_complex
      # puts response
      assert_instance_of HTTP::Response, response
    end
  end

  # find
  resources.each do |resource|
    uuid = random_singleton_uuid resource
    next unless uuid
    test_name = "test_#{resource}_#{uuid}_find"
    define_method(test_name) do
      # puts test_name
      resource_instance = resource_instance(resource)
      response = resource_instance.find id: uuid
      # puts response
      assert_instance_of HTTP::Response, response
    end
  end

  # meta
  resources.each do |resource|
    meta_methods.each do |meta_type|
      test_name = "test_#{resource}_meta_#{meta_type}"
      define_method(test_name) do
        # puts test_name
        resource_instance = resource_instance(resource)
        response = resource_instance.send meta_type
        # puts response
        assert_instance_of HTTP::Response, response
      end
    end
  end

end