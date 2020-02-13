require 'test_xml_extractor_helper'
require_relative '../common/name_header'
require_relative '../common/person_name'

class TestXMLExtractorPerson < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::REST::Client.new config
    response = client.persons.find id: id
    Puree::XMLExtractor::Person.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Person.new xml

    assert_instance_of Puree::XMLExtractor::Person, xml_extractor
  end

  def test_core
    # Peter Diggle
    id = '811d7fc3-047a-40d2-89e6-c85d14a97fb8'

    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Array, x.affiliations
    assert_instance_of Puree::Model::OrganisationalUnitHeader, x.affiliations.first
    assert x.affiliations.first.data?
    assert_name_header x.affiliations.first

    assert_instance_of Array, x.email_addresses
    assert_instance_of String, x.email_addresses.first
    refute_empty x.email_addresses.first

    assert_instance_of Array, x.image_urls
    assert_instance_of String, x.image_urls.first
    refute_empty x.image_urls.first

    assert_instance_of Array, x.identifiers
    assert_instance_of Puree::Model::Identifier, x.identifiers.first
    assert x.identifiers.first.data?

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords.first
    refute_empty x.keywords.first

    assert_instance_of Puree::Model::PersonName, x.name
    assert x.name.data?
    assert_person_name x.name

    assert_instance_of String, x.orcid
    refute_empty x.orcid

    assert_instance_of Array, x.other_names
    assert_instance_of Puree::Model::PersonName, x.other_names.first
    assert x.other_names.first.data?
  end

  # def test_scopus_id
  #   # Elizabeth Shove
  #   id = '4c9b74b5-2f7a-4d4d-89fb-64a2e43d3cad'
  # end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Person.new xml

    assert_instance_of Array, x.affiliations
    assert_empty x.affiliations

    assert_instance_of Array, x.email_addresses
    assert_empty x.email_addresses

    assert_instance_of Array, x.identifiers
    assert_empty x.identifiers

    assert_instance_of Array, x.image_urls
    assert_empty x.image_urls

    assert_instance_of Array, x.keywords
    assert_empty x.keywords

    assert_nil x.name

    assert_nil x.orcid

    assert_instance_of Array, x.other_names
    assert_empty x.other_names
  end

  def test_model
    # Peter Diggle
    id = '811d7fc3-047a-40d2-89e6-c85d14a97fb8'

    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Person, x.model
  end
end