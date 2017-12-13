require 'test_xml_extractor_helper'

class TestXMLExtractorExternalPublisher < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::APIClient.new config
    response = client.publishers.find id: id
    Puree::XMLExtractor::Publisher.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Publisher.new xml: xml

    assert_instance_of Puree::XMLExtractor::Publisher, xml_extractor
  end

  def test_core
    # Cambridge University Press
    id = '46065866-5e59-4761-a982-55b382579fdf'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of String, x.name
    refute_empty x.name
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Publisher.new xml: xml

    assert_nil x.name
  end

  def test_model
    # Cambridge University Press
    id = '46065866-5e59-4761-a982-55b382579fdf'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Publisher, x.model
  end

end