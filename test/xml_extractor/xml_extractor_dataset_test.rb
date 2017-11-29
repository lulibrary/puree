require 'test_helper'

class TestXMLExtractorDataset < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.datasets.find id: id
    Puree::XMLExtractor::Dataset.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Dataset.new xml: xml

    assert_instance_of Puree::XMLExtractor::Dataset, xml_extractor
  end

  def test_most
    # The 2014 Ebola virus disease outbreak in West Africa
    id = 'b050f4b5-e272-4914-8cac-3bdc1e673c58'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Array, x.associated
    assert_instance_of Puree::Model::RelatedContentHeader, x.associated[0]

    assert_instance_of Time, x.available

    assert_instance_of String, x.description

    assert_instance_of String, x.doi

    assert_instance_of Array, x.files
    assert_instance_of Puree::Model::File, x.files[0]

    assert_instance_of Array, x.keywords
    assert_instance_of String, x.keywords[0]

    assert_instance_of Array, x.organisations
    assert_instance_of Puree::Model::OrganisationHeader, x.organisations[0]

    assert_instance_of Puree::Model::OrganisationHeader, x.owner

    assert_instance_of Array, x.persons_internal
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_internal[0]

    assert_instance_of Array, x.persons_external
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_external[0]

    assert_instance_of Puree::Model::TemporalRange, x.production

    assert_instance_of Array, x.publications
    assert_instance_of Puree::Model::RelatedContentHeader, x.publications[0]

    assert_instance_of String, x.publisher

    assert_instance_of Array, x.spatial_places
    assert_instance_of String, x.spatial_places[0]

    assert_instance_of Puree::Model::TemporalRange, x.temporal

    assert_instance_of String, x.title

    assert_instance_of String, x.workflow_state
  end

  def test_persons_other
    # Plant diversity and root traits influence soil physical properties
    id = '18cb8b7c-c3dd-43b8-ac65-bdf76910a6cc'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.persons_other
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_other[0]
  end

  def test_persons_spatial_point
    # Influenza C in Lancaster, winter 2014-2015
    id = 'a762a8a2-a9ed-4abb-ba91-a67752b1c54d'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::SpatialPoint, x.spatial_point
  end

end