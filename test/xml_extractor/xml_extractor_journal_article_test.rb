require 'test_helper'

class TestXMLExtractorJournalArticle < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::JournalArticle.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::JournalArticle.new xml: xml

    assert_instance_of Puree::XMLExtractor::JournalArticle, xml_extractor
  end

  def test_core
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    x = xml_extractor_from_id id

    asserts_resource x

    assert_instance_of Fixnum, x.issue

    assert_instance_of Puree::Model::JournalHeader, x.journal
    assert_equal true, x.journal.data?

    assert_instance_of String, x.page_range
    refute_empty x.page_range

    assert_instance_of Fixnum, x.pages

    assert_includes [true, false], x.peer_reviewed

    assert_instance_of Fixnum, x.volume
  end

end