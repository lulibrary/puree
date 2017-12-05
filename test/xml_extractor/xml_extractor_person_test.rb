require 'test_helper'

class TestXMLExtractorPerson < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.persons.find id: id
    Puree::XMLExtractor::Person.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Person.new xml: xml

    assert_instance_of Puree::XMLExtractor::Person, xml_extractor
  end

  def test_core
    # Peter Diggle
    id = '811d7fc3-047a-40d2-89e6-c85d14a97fb8'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Array, x.affiliations
    assert_instance_of Puree::Model::OrganisationHeader, x.affiliations.first
    assert_equal true, x.affiliations.first.data?

    assert_instance_of Array, x.email_addresses
    assert_instance_of String, x.email_addresses.first
    refute_empty x.email_addresses.first

    assert_instance_of String, x.employee_id
    refute_empty x.employee_id

    assert_instance_of String, x.hesa_id
    refute_empty x.hesa_id

    assert_instance_of Array, x.image_urls
    assert_instance_of String, x.image_urls.first
    refute_empty x.image_urls.first

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords.first
    refute_empty x.keywords.first

    assert_instance_of Puree::Model::PersonName, x.name
    assert_equal true, x.name.data?

    assert_instance_of String, x.orcid
    refute_empty x.orcid
  end

  def test_scopus_id
    # Elizabeth Shove
    id = '4c9b74b5-2f7a-4d4d-89fb-64a2e43d3cad'
    x = xml_extractor_from_id id

    assert_instance_of String, x.scopus_id
    refute_empty x.scopus_id
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Person.new xml: xml

    assert_instance_of Array, x.affiliations
    assert_empty x.affiliations

    assert_instance_of Array, x.email_addresses
    assert_empty x.email_addresses

    assert_nil x.employee_id

    assert_nil x.hesa_id

    assert_instance_of Array, x.image_urls
    assert_empty x.image_urls

    assert_instance_of Array, x.keywords
    assert_empty x.keywords

    assert_nil x.name

    assert_nil x.orcid

    assert_nil x.scopus_id
  end

  def test_core
    # Peter Diggle
    id = '811d7fc3-047a-40d2-89e6-c85d14a97fb8'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Person, x.model
  end
end