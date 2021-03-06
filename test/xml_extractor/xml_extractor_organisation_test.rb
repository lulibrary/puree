require 'test_xml_extractor_helper'
require_relative '../common/name_header'
require_relative '../common/address'

class TestXMLExtractorOrganisation < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::REST::Client.new config
    response = client.organisational_units.find id: id
    Puree::XMLExtractor::OrganisationalUnit.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::OrganisationalUnit.new xml

    assert_instance_of Puree::XMLExtractor::OrganisationalUnit, xml_extractor
  end

  def test_core
    # Faculty of Health and Medicine
    id = '8a58c4ad-2d5a-463a-841a-38839ff73a63'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Puree::Model::Address, x.address
    assert_address x.address

    assert_instance_of Array, x.email_addresses
    assert_instance_of String, x.email_addresses.first
    refute_empty x.email_addresses.first

    assert_instance_of String, x.name
    refute_empty x.name

    assert_instance_of Puree::Model::OrganisationalUnitHeader, x.parent
    assert x.parent.data?
    assert_name_header x.parent

    assert_instance_of Array, x.parents
    assert_instance_of Puree::Model::OrganisationalUnitHeader, x.parents.first
    assert x.parents.first.data?
    assert_name_header x.parents.first

    assert_instance_of Array, x.phone_numbers
    assert_instance_of String, x.phone_numbers.first
    refute_empty x.phone_numbers.first

    assert_instance_of String, x.type
    refute_empty x.type

    assert_instance_of Array, x.urls
    assert_instance_of String, x.urls.first
    refute_empty x.urls.first
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::OrganisationalUnit.new xml

    assert_nil x.address

    assert_instance_of Array, x.email_addresses
    assert_empty x.email_addresses

    assert_nil x.name

    assert_nil x.parent

    assert_instance_of Array, x.parents
    assert_empty x.parents

    assert_instance_of Array, x.phone_numbers
    assert_empty x.phone_numbers

    assert_nil x.type

    assert_instance_of Array, x.urls
    assert_empty x.urls
  end

  def test_model
    # Faculty of Health and Medicine
    id = '8a58c4ad-2d5a-463a-841a-38839ff73a63'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::OrganisationalUnit, x.model
  end

end