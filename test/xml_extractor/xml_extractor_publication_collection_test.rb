require 'test_xml_extractor_helper'

class TestXMLExtractorPublicationCollection < Minitest::Test

  def test_classify
    client = Puree::API::RESTClient.new config
    response = client.research_outputs.all params: { size: collection_size }
    data = Puree::XMLExtractor::PublicationCollection.classify response.to_s

    # puts data

    assert_instance_of Hash, data

    journal_articles = data[:journal_article]
    assert_instance_of Array, journal_articles
    assert_instance_of Puree::Model::JournalArticle, journal_articles.first if !journal_articles.empty?
    assert_equal 'Journal article', journal_articles.first.type if !journal_articles.empty?

    conference_papers = data[:conference_paper]
    assert_instance_of Array, conference_papers
    assert_instance_of Puree::Model::ConferencePaper, conference_papers.first if !conference_papers.empty?
    assert_equal 'Conference paper', conference_papers.first.type if !conference_papers.empty?

    theses = data[:thesis]
    assert_instance_of Array, theses
    assert_instance_of Puree::Model::Thesis, theses.first if !theses.empty?
    assert_equal 'Thesis', theses.first.type if !theses.empty?

    others = data[:other]
    assert_instance_of Array, others
    assert_instance_of Puree::Model::Publication, others.first if !others.empty?

  end

  def test_absence
    xml = '<foo/>'
    data = Puree::XMLExtractor::PublicationCollection.classify xml

    assert_instance_of Hash, data

    journal_articles = data[:journal_article]
    assert_instance_of Array, journal_articles
    assert_empty journal_articles

    conference_papers = data[:conference_paper]
    assert_instance_of Array, conference_papers
    assert_empty conference_papers

    theses = data[:thesis]
    assert_instance_of Array, theses
    assert_empty theses

    others = data[:other]
    assert_instance_of Array, others
    assert_empty others
  end
end