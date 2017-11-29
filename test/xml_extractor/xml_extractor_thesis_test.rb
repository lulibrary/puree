require 'test_helper'

class TestXMLExtractorThesis < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::Thesis.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Thesis.new xml: xml

    assert_instance_of Puree::XMLExtractor::Thesis, xml_extractor
  end

  def test_core
    # Multimodalita e 'city branding'
    id = '376173c0-fd7a-4d63-93d3-3f2e58e8dc01'
    x = xml_extractor_from_id id

    assert_instance_of Time, x.award_date
    assert_instance_of Puree::Model::ExternalOrganisationHeader, x.awarding_institution
  end

  def test_sponsors
    id = 'c5b50358-4c42-48fb-ae53-8f360edcb51d'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.sponsors
    assert_instance_of String, x.sponsors[0]
  end

  def test_qualification
    id = 'c5b50358-4c42-48fb-ae53-8f360edcb51d'
    x = xml_extractor_from_id id

    assert_instance_of String, x.qualification

  end

end