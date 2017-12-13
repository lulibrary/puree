require 'test_xml_extractor_helper'

# Tests Resource methods, via a JournalArticle
# Unless otherwise stated, tests Publication methods via a JournalArticle
class TestXMLExtractorPublication < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::RESTClient.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::JournalArticle.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Publication.new xml

    assert_instance_of Puree::XMLExtractor::Publication, xml_extractor
  end

  def test_core
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Array, x.associated
    assert_instance_of Puree::Model::RelatedContentHeader, x.associated.first
    assert_equal true, x.associated.first.data?

    assert_instance_of String, x.category
    refute_empty x.category

    assert_instance_of String, x.description
    refute_empty x.description

    assert_instance_of String, x.doi
    refute_empty x.doi

    assert_instance_of Array, x.files
    assert_instance_of Puree::Model::File, x.files.first
    assert_equal true, x.files.first.data?

    assert_instance_of String, x.language
    refute_empty x.language

    assert_instance_of Array, x.links
    assert_instance_of String, x.links.first
    refute_empty x.links.first

    assert_instance_of Array, x.organisations
    assert_instance_of Puree::Model::OrganisationHeader, x.organisations.first
    assert_equal true, x.organisations.first.data?

    assert_instance_of Puree::Model::OrganisationHeader, x.owner
    assert_equal true, x.owner.data?

    assert_instance_of Array, x.persons_internal
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_internal.first
    assert_equal true, x.persons_internal.first.data?

    assert_instance_of Array, x.persons_external
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_external.first
    assert_equal true, x.persons_external.first.data?

    # persons_other, see Dataset test

    assert_instance_of Array, x.statuses
    assert_instance_of Puree::Model::PublicationStatus, x.statuses.first
    assert_equal true, x.statuses.first.data?

    assert_instance_of String, x.workflow
    refute_empty x.workflow
  end

  def test_bibliographical_note
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of String, x.bibliographical_note
    refute_empty x.bibliographical_note
  end

  def test_keywords
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords.first
    refute_empty x.keywords.first
  end

  def test_scopus_citations_count
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of Fixnum, x.scopus_citations_count
  end

  def test_subtitle
    # Language testing and assessment (Part 1)
    id = 'b5195a1f-15f0-4b94-9378-d6a19dc0c4a4'
    x = xml_extractor_from_id id

    assert_instance_of String, x.subtitle
    refute_empty x.subtitle
  end

  def test_translated_titles
    # Multimodalita e 'city branding'
    id = '376173c0-fd7a-4d63-93d3-3f2e58e8dc01'
    client = Puree::API::RESTClient.new config
    response = client.research_outputs.find id: id
    x = Puree::XMLExtractor::Thesis.new response.to_s

    # assert_instance_of String, x.subtitle  # also has sub

    assert_instance_of String, x.translated_subtitle
    refute_empty x.translated_subtitle

    assert_instance_of String, x.translated_title
    refute_empty x.translated_title
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::JournalArticle.new xml

    assert_instance_of Array, x.associated
    assert_empty x.associated

    assert_nil x.bibliographical_note

    assert_nil x.category

    assert_nil x.description

    assert_nil x.doi

    assert_instance_of Array, x.files
    assert_empty x.files

    assert_instance_of Array, x.keywords
    assert_empty x.keywords

    assert_nil x.language

    assert_instance_of Array, x.links
    assert_empty x.links

    assert_instance_of Array, x.organisations
    assert_empty x.organisations

    assert_nil x.owner

    assert_instance_of Array, x.persons_internal
    assert_empty x.persons_internal

    assert_instance_of Array, x.persons_external
    assert_empty x.persons_external

    assert_instance_of Array, x.persons_other
    assert_empty x.persons_other

    assert_instance_of Array, x.statuses
    assert_empty x.statuses

    assert_nil x.subtitle

    assert_nil x.translated_subtitle

    assert_nil x.translated_title

    assert_nil x.workflow
  end

  def test_model
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    client = Puree::API::RESTClient.new config
    response = client.research_outputs.find id: id
    x = Puree::XMLExtractor::Publication.new response.to_s

    assert_instance_of Puree::Model::Publication, x.model
  end
end