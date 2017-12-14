require 'test_xml_extractor_helper'

class TestXMLExtractorDataset < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::RESTClient.new config
    response = client.datasets.find id: id
    Puree::XMLExtractor::Dataset.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    x = Puree::XMLExtractor::Dataset.new xml

    assert_instance_of Puree::XMLExtractor::Dataset, x
  end

  def test_core
    # The 2014 Ebola virus disease outbreak in West Africa
    id = 'b050f4b5-e272-4914-8cac-3bdc1e673c58'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Time, x.available

    assert_instance_of String, x.description
    refute_empty x.description

    assert_instance_of String, x.doi
    refute_empty x.doi

    assert_instance_of Array, x.files
    assert_instance_of Puree::Model::File, x.files.first
    assert_equal true, x.files.first.data?

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords.first
    refute_empty x.keywords.first

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

    assert_instance_of Puree::Model::TemporalRange, x.production
    assert_equal true, x.production.data?

    assert_instance_of Array, x.research_outputs
    assert_instance_of Puree::Model::RelatedContentHeader, x.research_outputs.first
    assert_equal true, x.research_outputs.first.data?

    assert_instance_of String, x.publisher
    refute_empty x.publisher

    assert_instance_of Array, x.spatial_places
    assert_instance_of String, x.spatial_places.first
    refute_empty x.spatial_places.first

    assert_instance_of Puree::Model::TemporalRange, x.temporal
    assert_equal true, x.temporal.data?

    assert_instance_of String, x.title
    refute_empty x.title

    assert_instance_of String, x.workflow
    refute_empty x.workflow
  end

  def test_persons_other
    # Plant diversity and root traits influence soil physical properties
    id = '18cb8b7c-c3dd-43b8-ac65-bdf76910a6cc'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.persons_other
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_other.first
    assert_equal true, x.persons_other.first.data?
  end

  def test_spatial_point
    # Influenza C in Lancaster, winter 2014-2015
    id = 'a762a8a2-a9ed-4abb-ba91-a67752b1c54d'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::SpatialPoint, x.spatial_point
    assert_equal true, x.spatial_point.data?
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Dataset.new xml

    assert_nil x.available

    assert_nil x.description

    assert_nil x.doi

    assert_instance_of Array, x.files
    assert_empty x.files

    assert_instance_of Array, x.keywords
    assert_empty x.keywords

    assert_instance_of Array, x.organisations
    assert_empty x.organisations

    assert_nil x.owner

    assert_instance_of Array, x.persons_internal
    assert_empty x.persons_internal

    assert_instance_of Array, x.persons_external
    assert_empty x.persons_external

    assert_instance_of Array, x.persons_other
    assert_empty x.persons_other

    assert_nil x.production

    assert_instance_of Array, x.research_outputs
    assert_empty x.research_outputs

    assert_nil x.publisher

    assert_instance_of Array, x.spatial_places
    assert_empty x.spatial_places

    assert_nil x.spatial_point

    assert_nil x.temporal

    assert_nil x.title

    assert_nil x.workflow
  end

  def test_model
    # The 2014 Ebola virus disease outbreak in West Africa
    id = 'b050f4b5-e272-4914-8cac-3bdc1e673c58'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Dataset, x.model
  end

end