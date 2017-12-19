require 'test_rest_helper'

class TestResourceBase < Minitest::Test

  def test_instance
    base = Puree::REST::Base.new config
    assert_instance_of Puree::REST::Base, base
  end

  # Private get_request_X methods (used by all resources) tested via Client
  # public interface. Exemplar resource is Person.

  def test_get_request_collection
    response = client.persons.all
    # puts response
    assert_instance_of HTTP::Response, response
  end

  def test_get_request_singleton
    uuid = random_singleton_uuid :person
    response = client.persons.find id: uuid
    # puts response
    assert_instance_of HTTP::Response, response
  end

  def test_get_request_meta
    response = client.persons.renderings
    # puts response
    assert_instance_of HTTP::Response, response
  end

  def test_get_request_collection_subcollection
    response = client.persons.active
    # puts response
    assert_instance_of HTTP::Response, response
  end

  def test_get_request_singleton_subcollection
    uuid = random_singleton_uuid :person
    response = client.persons.projects id: uuid
    # puts response
    assert_instance_of HTTP::Response, response
  end

end