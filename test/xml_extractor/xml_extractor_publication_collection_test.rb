require 'test_helper'

class TestXMLExtractorPublicationCollection < Minitest::Test

  def xml_extractor_from_id(id)
    client = Purification::Client.new config
    response = client.research_outputs.find id: id
    Puree::XMLExtractor::JournalArticle.new xml: response.to_s
  end

  def test_initialize
    xml = '<foo/>'
    xml_extractor = Puree::XMLExtractor::Publication.new xml: xml

    assert_instance_of Puree::XMLExtractor::Publication, xml_extractor
  end

  def test_classify
    client = Purification::Client.new config
    response = client.research_outputs.all
    classification = Puree::XMLExtractor::PublicationCollection.classify xml: response.to_s

    puts classification

    assert_instance_of Hash, classification

    journal_articles = classification[:journal_article]
    assert_instance_of Array, journal_articles
    assert_instance_of Puree::Model::JournalArticle, journal_articles.first if !journal_articles.empty?

    papers = classification[:paper]
    assert_instance_of Array, papers
    assert_instance_of Puree::Model::Paper, papers.first if !papers.empty?

    theses = classification[:thesis]
    assert_instance_of Array, theses
    assert_instance_of Puree::Model::Thesis, theses.first if !theses.empty?

    others = classification[:other]
    assert_instance_of Array, others
    assert_instance_of Puree::Model::Publication, others.first if !others.empty?
  end

  def test_absence
    xml = '<foo/>'
    classification = Puree::XMLExtractor::PublicationCollection.classify xml: xml

    assert_instance_of Hash, classification

    journal_articles = classification[:journal_article]
    assert_instance_of Array, journal_articles
    assert_empty journal_articles

    papers = classification[:paper]
    assert_instance_of Array, papers
    assert_empty papers

    theses = classification[:thesis]
    assert_instance_of Array, theses
    assert_empty theses

    others = classification[:other]
    assert_instance_of Array, others
    assert_empty others
  end
end