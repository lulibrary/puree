require 'test_xml_extractor_helper'
require_relative '../common/title_header'

class TestXMLExtractorJournalArticle < Minitest::Test

  def xml_extractor_from_id(id)
    client = Puree::REST::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::JournalArticle.new response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::JournalArticle.new xml

    assert_instance_of Puree::XMLExtractor::JournalArticle, xml_extractor
  end

  def test_core
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Integer, x.issue

    assert_instance_of Puree::Model::JournalHeader, x.journal
    assert_title_header x.journal

    assert_instance_of String, x.page_range
    refute_empty x.page_range

    assert_instance_of Integer, x.pages

    assert [true, false].include? x.peer_reviewed

    assert_instance_of Integer, x.volume
  end

  def test_absence
    xml = '<foo/>'
    x = Puree::XMLExtractor::JournalArticle.new xml

    assert_nil x.issue

    assert_nil x.journal

    assert_nil x.page_range

    assert_nil x.pages

    assert_nil x.peer_reviewed

    assert_nil x.volume
  end

  def test_model
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    x = xml_extractor_from_id id

    assert_instance_of Puree::Model::JournalArticle, x.model

  end

end