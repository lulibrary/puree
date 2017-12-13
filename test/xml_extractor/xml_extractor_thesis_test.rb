require 'test_xml_extractor_helper'

class TestXMLExtractorThesis < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::APIClient.new config
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

    asserts_resource x

    assert_instance_of Time, x.award_date

    assert_instance_of Puree::Model::ExternalOrganisationHeader, x.awarding_institution
    assert_equal true,  x.awarding_institution.data?

    assert_instance_of String, x.type
    refute_empty x.type
  end

  def test_sponsors
    # A comparative study of the fundamental juridical nature, classification and private law enforcement of jurisdiction and choice of law agreements in the English Common Law of Conflict of Laws, the European Union Private International Law Regime and the Hague Convention on Choice of Court Agreements
    id = 'c5b50358-4c42-48fb-ae53-8f360edcb51d'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.sponsors
    assert_instance_of String, x.sponsors.first
    refute_empty x.sponsors.first
  end

  def test_qualification
    # A comparative study of the fundamental juridical nature, classification and private law enforcement of jurisdiction and choice of law agreements in the English Common Law of Conflict of Laws, the European Union Private International Law Regime and the Hague Convention on Choice of Court Agreements
    id = 'c5b50358-4c42-48fb-ae53-8f360edcb51d'
    x = xml_extractor_from_id id

    assert_instance_of String, x.qualification
    refute_empty x.qualification
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Thesis.new xml: xml

    assert_nil x.awarding_institution

    assert_instance_of Array, x.sponsors
    assert_empty x.sponsors

    assert_nil x.qualification

    assert_nil x.type
  end

  def test_model
    # Multimodalita e 'city branding'
    id = '376173c0-fd7a-4d63-93d3-3f2e58e8dc01'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Thesis, x.model
  end

end