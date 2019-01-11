require 'test_xml_extractor_helper'
require_relative '../common/endeavour_person'
require_relative '../common/name_header'
require_relative '../common/related_content_header'

# Tests Resource methods, via a JournalArticle
# Unless otherwise stated, tests ResearchOutput methods via a JournalArticle
class TestXMLExtractorResearchOutput < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::REST::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::JournalArticle.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::ResearchOutput.new xml

    assert_instance_of Puree::XMLExtractor::ResearchOutput, xml_extractor
  end

  def test_core
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of String, x.category
    refute_empty x.category

    assert_instance_of String, x.description
    refute_empty x.description

    assert_instance_of String, x.doi
    refute_empty x.doi.to_s

    assert_instance_of Array, x.files
    data = x.files.first
    assert_instance_of Puree::Model::File, data
    assert data.data?
    assert_instance_of String, data.name
    refute_empty data.name
    assert_instance_of String, data.mime
    refute_empty data.mime
    assert_instance_of Integer, data.size
    assert_instance_of String, data.url
    refute_empty data.url

    assert_instance_of String, x.language
    refute_empty x.language

    assert_instance_of Array, x.links
    assert_instance_of String, x.links.first
    refute_empty x.links.first

    assert_instance_of String, x.open_access_permission
    refute_empty x.open_access_permission

    assert_instance_of Array, x.organisational_units
    assert_name_header x.organisational_units.first

    assert_name_header x.owner

    assert_instance_of Array, x.persons_internal
    assert_endeavour_person x.persons_internal.first

    assert_instance_of Array, x.persons_external
    assert_endeavour_person x.persons_external.first

    assert_instance_of Array, x.publication_statuses
    data = x.publication_statuses.first
    assert_instance_of Puree::Model::PublicationStatus, data
    assert data.data?
    assert_instance_of String, data.stage
    refute_empty data.stage
    assert_instance_of Time, data.date

    # persons_other, see Dataset test

    assert_instance_of Array, x.research_outputs
    assert_related_content_header x.research_outputs.first

    assert_instance_of String, x.type
    refute_empty x.type

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

  def test_dois
    # The spatial-temporal characteristics and health impacts of ambient fine particulate matter in China
    id = 'a06ce5cd-a9e8-4e87-aa55-7a8616d1d69d'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.dois
    assert_instance_of String, x.dois.first
    refute_empty x.dois
  end

  def test_keywords
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords.first
    refute_empty x.keywords.first
  end

  # def test_projects
  #   # Measurements of the Higgs boson production and decay rates and coupling strengths using pp collision data at s√=7s=7 and 8 TeV in the ATLAS experiment
  #   id = '24ec62e9-a3cc-4402-9ec9-396067949031'
  #   x = xml_extractor_from_id id
  #
  #   assert_instance_of Array, x.projects
  #
  #   assert_instance_of Puree::Model::RelatedContentHeader, x.projects.first
  #   assert_related_content_header x.projects.first
  # end

  def test_projects_2
    # Plant diversity and root traits benefit physical properties key to soil function in grasslands
    id = '458ad0e7-6950-4e30-9374-125fbf628548'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.projects

    # Lancaster Environment Centre Project
    # Active on 2019-01-11
    assert_instance_of Puree::Model::RelatedContentHeader, x.projects.first
    assert_related_content_header x.projects.first
    assert x.projects.first.uuid === 'a2bf957f-d54b-495a-97ac-cf360eeda67f'
  end

  def test_scopus_citations_count
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of Integer, x.scopus_citations_count
  end

  def test_scopus_id
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of String, x.scopus_id
  end

  def test_scopus_metrics
    # The effect of humic substances on barite precipitation-dissolution behaviour in natural and synthetic lake waters
    id = 'ce76dbda-8b22-422b-9bb6-8143820171b8'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.scopus_metrics
    data = x.scopus_metrics.first
    assert_instance_of Puree::Model::ResearchOutputScopusMetric, data
    assert data.data?
    assert_instance_of Integer, data.value
    assert_instance_of Integer, data.year
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
    client = Puree::REST::Client.new config
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

    assert_nil x.bibliographical_note

    assert_nil x.category

    assert_nil x.description

    assert_nil x.doi

    assert_empty x.dois

    assert_instance_of Array, x.files
    assert_empty x.files

    assert_instance_of Array, x.keywords
    assert_empty x.keywords

    assert_nil x.language

    assert_instance_of Array, x.links
    assert_empty x.links

    assert_nil x.open_access_permission

    assert_instance_of Array, x.organisational_units
    assert_empty x.organisational_units

    assert_nil x.owner

    assert_instance_of Array, x.persons_internal
    assert_empty x.persons_internal

    assert_instance_of Array, x.persons_external
    assert_empty x.persons_external

    assert_instance_of Array, x.persons_other
    assert_empty x.persons_other

    assert_instance_of Array, x.projects
    assert_empty x.projects

    assert_instance_of Array, x.publication_statuses
    assert_empty x.publication_statuses

    assert_instance_of Array, x.research_outputs
    assert_empty x.research_outputs

    assert_nil x.scopus_citations_count

    assert_instance_of Array, x.scopus_metrics
    assert_empty x.scopus_metrics

    assert_nil x.subtitle

    assert_nil x.type

    assert_nil x.translated_subtitle

    assert_nil x.translated_title

    assert_nil x.workflow
  end

  def test_model
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    client = Puree::REST::Client.new config
    response = client.research_outputs.find id: id
    x = Puree::XMLExtractor::ResearchOutput.new response.to_s

    assert_instance_of Puree::Model::ResearchOutput, x.model
  end

  def test_projects_snippet
    # Improving the language skills of Pre-Kindergarten students
    # id = '54ac6efc-1739-4e42-b4c9-bcb1c6dfd664'

    xml =
    '<contributionToJournal>
      <relatedProjects>
        <relatedProject uuid="fe8aebdf-a926-4e7b-adf1-082425e50330">
          <name>The Language Bases of Reading Comprehension</name>
	   	    <type uri="/dk/atira/pure/upmproject/upmprojecttypes/upmproject/research">Research</type>
	 	    </relatedProject>
	    </relatedProjects>
    </contributionToJournal>'

    x = Puree::XMLExtractor::JournalArticle.new xml
    assert_instance_of Array, x.projects
    assert_instance_of Puree::Model::RelatedContentHeader, x.projects.first
    assert_related_content_header x.projects.first
  end
end