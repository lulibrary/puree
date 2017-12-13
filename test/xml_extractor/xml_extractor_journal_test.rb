require 'test_xml_extractor_helper'

class TestXMLExtractorJournal < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::RESTClient.new config
    response = client.journals.find id: id
    Puree::XMLExtractor::Journal.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Journal.new xml

    assert_instance_of Puree::XMLExtractor::Journal, xml_extractor
  end

  def test_core
    # Chemical Geology
    id = '95e40a10-1799-4e74-9a70-8b03f27d9acb'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of String, x.issn
    refute_empty x.issn

    assert_instance_of String, x.publisher
    refute_empty x.publisher

    assert_instance_of String, x.title
    refute_empty x.title
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Journal.new xml

    assert_nil x.issn

    assert_nil x.publisher

    assert_nil x.title
  end

  def test_model
    # Chemical Geology
    id = '95e40a10-1799-4e74-9a70-8b03f27d9acb'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Journal, x.model
  end
end