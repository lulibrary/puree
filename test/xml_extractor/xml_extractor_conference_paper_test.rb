require 'test_xml_extractor_helper'

class TestXMLExtractorPaper < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::REST::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::ConferencePaper.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::ConferencePaper.new xml

    assert_instance_of Puree::XMLExtractor::ConferencePaper, xml_extractor
  end

  def test_core
    # A Negative Effect of Evaluation Upon Analogical Problem Solving
    id = '96e1495e-70a2-4529-9721-33b2cb62df8d'
    x = xml_extractor_from_id id

    asserts_resource x

    event = x.event
    assert_instance_of Puree::Model::EventHeader, event
    assert event.data?

    assert_instance_of String, event.title
    refute_empty event.title

    assert_instance_of String, event.uuid
    refute_empty event.uuid

    assert_instance_of Integer, x.pages
  end

  def test_page_range
    # Development of a Motion Tracking 3D CAD Input System
    id = 'db2193b7-5cc7-496d-9bd5-35192c6d7ece'
    x = xml_extractor_from_id id

    assert_instance_of String, x.page_range
    refute_empty x.page_range
  end

  def test_peer_reviewed
    # Development of a Motion Tracking 3D CAD Input System
    id = 'db2193b7-5cc7-496d-9bd5-35192c6d7ece'
    x = xml_extractor_from_id id

    assert x.peer_reviewed
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::ConferencePaper.new xml

    assert_nil x.event

    assert_nil x.pages

    assert_nil x.page_range

    assert_nil x.peer_reviewed
  end

  def test_model
    # A Negative Effect of Evaluation Upon Analogical Problem Solving
    id = '96e1495e-70a2-4529-9721-33b2cb62df8d'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::ConferencePaper, x.model
  end

end