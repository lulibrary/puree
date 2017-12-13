require 'test_xml_extractor_helper'

class TestXMLEventJournal < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::API::RESTClient.new config
    response = client.events.find id: id
    Puree::XMLExtractor::Event.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Event.new xml

    assert_instance_of Puree::XMLExtractor::Event, xml_extractor
  end

  def test_core
    # 31st Annual European Meeting on Atmospheric Studies by Optical Methods and 1st International Riometer Workshop
    id = 'cd2bf302-4629-4f71-9c02-2dfe50a384bf'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of String, x.city
    refute_empty x.city

    assert_instance_of Puree::Model::TemporalRange, x.date
    assert_equal true, x.date.data?

    assert_instance_of String, x.title
    refute_empty x.title

    assert_instance_of String, x.type
    refute_empty x.type
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::Event.new xml

    assert_nil x.city

    assert_nil x.date

    assert_nil x.title

    assert_nil x.type
  end

  def test_model
    # 31st Annual European Meeting on Atmospheric Studies by Optical Methods and 1st International Riometer Workshop
    id = 'cd2bf302-4629-4f71-9c02-2dfe50a384bf'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::Event, x.model
  end
end