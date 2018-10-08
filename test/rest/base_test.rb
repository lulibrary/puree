require 'test_rest_helper'

class TestResourceBase < Minitest::Test

  def test_instance
    base = Puree::REST::Base.new config
    assert_instance_of Puree::REST::Base, base
  end

  # Private request methods (used by all resources) tested via Client
  # public interface. Exemplar resource is Person.
  #
  def test_post_request_collection
    params = {
        size: 3,
        employmentTypeUri: ['/dk/atira/pure/person/employmenttypes/academic'],
        employmentStatus: 'ACTIVE'
    }
    response = client.persons.all_complex params: params
    # puts response
    assert_instance_of HTTP::Response, response
  end

  def test_collection_count
    params = {
      employmentTypeUri: ['/dk/atira/pure/person/employmenttypes/academic'],
      employmentStatus: 'ACTIVE'
    }
    extractor = Puree::Extractor::Person.new config
    count = extractor.count(params)
    assert_instance_of Fixnum, count
  end

  def test_get_request_collection
    response = client.persons.all params: {size: 5}, accept: :json
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