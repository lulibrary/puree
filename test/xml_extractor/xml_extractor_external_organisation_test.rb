require 'test_xml_extractor_helper'

class TestXMLExtractorExternalOrganisation < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::APIClient.new config
    response = client.external_organisations.find id: id
    Puree::XMLExtractor::ExternalOrganisation.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::ExternalOrganisation.new xml: xml

    assert_instance_of Puree::XMLExtractor::ExternalOrganisation, xml_extractor
  end

  def test_core
    # STFC
    id = '2ea6bbc4-c957-4a07-a1e7-604a2d944c20'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of String, x.name
    refute_empty x.name

    assert_instance_of String, x.type
    refute_empty x.type
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::ExternalOrganisation.new xml: xml

    assert_nil x.name

    assert_nil x.type
  end

  def test_model
    # STFC
    id = '2ea6bbc4-c957-4a07-a1e7-604a2d944c20'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::ExternalOrganisation, x.model
  end

end