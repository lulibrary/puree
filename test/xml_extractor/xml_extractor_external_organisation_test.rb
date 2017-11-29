require 'test_helper'

class TestXMLExtractorExternalOrganisation < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
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

    assert_instance_of String, x.name
    assert_instance_of String, x.type
  end

end