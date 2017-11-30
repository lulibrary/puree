require 'test_helper'

class TestXMLExtractorProject < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.projects.find id: id
    Puree::XMLExtractor::Project.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Project.new xml: xml

    assert_instance_of Puree::XMLExtractor::Project, xml_extractor
  end

  def test_core
    # The Channel Scheme - Preston
    id = '2af1fb5c-ac04-40f3-9cb4-073fb92fcf96'
    x = xml_extractor_from_id id

    assert_instance_of String, x.acronym
    refute_empty x.acronym

    assert_instance_of Array, x.external_organisations
    assert_instance_of Puree::Model::ExternalOrganisationHeader, x.external_organisations.first
    assert_equal true, x.external_organisations.first.data?

    assert_instance_of Array, x.organisations
    assert_instance_of Puree::Model::OrganisationHeader, x.organisations.first
    assert_equal true, x.organisations.first.data?

    assert_instance_of String, x.status
    refute_empty x.status

    assert_instance_of String, x.title
    refute_empty x.title

    assert_instance_of String, x.type
    refute_empty x.type

    assert_instance_of Array, x.persons_internal
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_internal.first
    assert_equal true, x.persons_internal.first.data?

    # persons_other, see Dataset test

    assert_instance_of Puree::Model::TemporalRange, x.temporal_actual
    assert_equal true, x.temporal_actual.data?
  end

  def test_description
    # Designing an inclusive curriculum in higher education
    id = '926f34e9-e461-406a-a2b8-3f831456ada0'
    x = xml_extractor_from_id id

    assert_instance_of String, x.description
    refute_empty x.description
  end

  def test_url
    # Designing an inclusive curriculum in higher education
    id = '926f34e9-e461-406a-a2b8-3f831456ada0'
    x = xml_extractor_from_id id

    assert_instance_of String, x.url
    refute_empty x.url
  end

  def test_persons_external
    # Children, flood and urban resilience
    id = 'a4d07102-8bbb-4110-8969-580a8fd019c0'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.persons_external
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_external.first
    assert_equal true, x.persons_external.first.data?
  end

end