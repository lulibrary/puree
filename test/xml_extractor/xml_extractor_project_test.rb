require 'test_xml_extractor_helper'
require_relative '../common/endeavour_person'
require_relative '../common/name_header'
require_relative '../common/temporal_range'

class TestXMLExtractorProject < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::REST::Client.new config
    response = client.projects.find id: id
    Puree::XMLExtractor::Project.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Project.new xml

    assert_instance_of Puree::XMLExtractor::Project, xml_extractor
  end

  def test_core
    # The Channel Scheme - Preston
    # id = '2af1fb5c-ac04-40f3-9cb4-073fb92fcf96'
    # FINISHED
    # uuid changed to
    id = '6acfd7ae-4012-4c82-bb71-2976dbbafbd6'
    # pure_id = '236466684'
    x = xml_extractor_from_id id

    assert_instance_of String, x.acronym
    refute_empty x.acronym

    assert_instance_of Array, x.external_organisations
    assert_instance_of Puree::Model::ExternalOrganisationHeader, x.external_organisations.first
    assert x.external_organisations.first.data?
    assert_name_header x.external_organisations.first

    assert_instance_of Array, x.organisational_units
    assert_instance_of Puree::Model::OrganisationalUnitHeader, x.organisational_units.first
    assert x.organisational_units.first.data?
    assert_name_header x.organisational_units.first

    assert_instance_of String, x.status
    refute_empty x.status

    assert_instance_of String, x.title
    refute_empty x.title

    assert_instance_of String, x.type
    refute_empty x.type

    assert_instance_of Array, x.persons_internal
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_internal.first
    assert x.persons_internal.first.data?
    assert_endeavour_person x.persons_internal.first

    # persons_other, see Dataset test

    assert_instance_of Puree::Model::TemporalRange, x.temporal
    assert_temporal_range x.temporal
  end

  def test_description
    # Designing an inclusive curriculum in higher education
    # id = '926f34e9-e461-406a-a2b8-3f831456ada0'
    # FINISHED
    # uuid changed to
    id = '2bf4b724-7c3a-49c7-8a5a-4060a2fc975f'
    # pure_id = '236382102'
    x = xml_extractor_from_id id

    assert_instance_of String, x.description
    refute_empty x.description
  end

  def test_identifiers
    # Blackburn Parenting and Intensive Family Support Project
    # id = '1b15fa94-39f0-4809-976a-a04b53592004'
    # FINISHED
    # uuid changed to
    id = 'fc3baafd-f147-4c07-9acc-c98b269fcc4c'
    # pure_id = '236466374'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.identifiers
    assert_instance_of Puree::Model::Identifier, x.identifiers.first
    assert x.identifiers.first.data?
  end

  def test_url
    # Designing an inclusive curriculum in higher education
    # id = '926f34e9-e461-406a-a2b8-3f831456ada0'
    # FINISHED
    # uuid changed to
    id = '2bf4b724-7c3a-49c7-8a5a-4060a2fc975f'
    # pure_id = '236382102'
    x = xml_extractor_from_id id

    assert_instance_of String, x.url
    refute_empty x.url
  end

  def test_persons_external
    # Children, flood and urban resilience
    # id = 'a4d07102-8bbb-4110-8969-580a8fd019c0'
    # FINISHED
    # uuid changed to
    id = '31834af4-2b68-49c4-9caf-6875d1ba78eb'
    # pure_id = '236476404'
    x = xml_extractor_from_id id

    assert_instance_of Array, x.persons_external
    assert_instance_of Puree::Model::EndeavourPerson, x.persons_external.first
    assert x.persons_external.first.data?
    assert_endeavour_person x.persons_external.first
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Project.new xml

    assert_nil x.acronym

    assert_nil x.description

    assert_instance_of Array, x.external_organisations
    assert_empty x.external_organisations

    assert_instance_of Array, x.identifiers
    assert_empty x.identifiers

    assert_instance_of Array, x.organisational_units
    assert_empty x.organisational_units

    assert_instance_of Array, x.persons_internal
    assert_empty x.persons_internal

    assert_instance_of Array, x.persons_external
    assert_empty x.persons_external

    assert_instance_of Array, x.persons_other
    assert_empty x.persons_other

    assert_nil x.status

    assert_nil x.temporal

    assert_nil x.title

    assert_nil x.type

    assert_nil x.url
  end

  def test_model
    # The Channel Scheme - Preston
    # id = '2af1fb5c-ac04-40f3-9cb4-073fb92fcf96'
    # FINISHED
    # uuid changed to
    id = '6acfd7ae-4012-4c82-bb71-2976dbbafbd6'
    # pure_id = '236466684'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Project, x.model
  end

end