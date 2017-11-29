require 'test_helper'

# Tests Resource methods, via a JournalArticle
# Unless otherwise stated, tests Publication methods via a JournalArticle
class TestXMLExtractorPublication < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::JournalArticle.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Publication.new xml: xml

    assert_instance_of Puree::XMLExtractor::Publication, xml_extractor
  end

  def test_core
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    x = xml_extractor_from_id id

    asserts_resource x # Resource methods

    assert_instance_of Array, x.associated
    assert_instance_of Puree::Model::RelatedContentHeader, x.associated[0]

    assert_instance_of String, x.category

    assert_instance_of String, x.description

    assert_instance_of String, x.doi

    assert_instance_of Array, x.files
    assert_instance_of Puree::Model::File, x.files[0]

    assert_instance_of String, x.language

    assert_instance_of Array, x.links
    assert_instance_of String, x.links[0]

    assert_instance_of Array, x.organisations
    assert_instance_of Puree::Model::OrganisationHeader, x.organisations[0]

    assert_instance_of Puree::Model::OrganisationHeader, x.owner

    assert_instance_of Array, x.persons_internal
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_internal[0]

    assert_instance_of Array, x.persons_external
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_external[0]

    assert_instance_of Array, x.statuses
    assert_instance_of Puree::Model::PublicationStatus, x.statuses[0]

    assert_instance_of String, x.workflow_state
  end

  def test_bibliographical_note
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of String, x.workflow_state
  end

  def test_keywords
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords[0]
  end

  def test_subtitle
    # Language testing and assessment (Part 1)
    id = 'b5195a1f-15f0-4b94-9378-d6a19dc0c4a4'
    x = xml_extractor_from_id id

    assert_instance_of String, x.subtitle
  end

  def test_translated_titles
    # Multimodalita e 'city branding'
    id = '376173c0-fd7a-4d63-93d3-3f2e58e8dc01'
    client = Purification::Client.new config
    response = client.research_outputs.find id: id
    x = Puree::XMLExtractor::Thesis.new xml: response.to_s

    # assert_instance_of String, x.subtitle  # also has sub
    assert_instance_of String, x.translated_subtitle
    assert_instance_of String, x.translated_title
  end


end