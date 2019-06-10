require 'test_xml_extractor_helper'

class TestXMLExtractorCollection < Minitest::Test

  def test_datasets
    client = Puree::REST::Client.new config
    response = client.datasets.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.datasets response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Dataset, data.first if !data.empty?
  end

  def test_events
    client = Puree::REST::Client.new config
    response = client.events.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.events response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Event, data.first if !data.empty?
  end

  def test_external_organisations
    client = Puree::REST::Client.new config
    response = client.external_organisations.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.external_organisations response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::ExternalOrganisation, data.first if !data.empty?
  end

  def test_journals
    client = Puree::REST::Client.new config
    response = client.journals.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.journals response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Journal, data.first if !data.empty?
  end

  def test_organisations
    client = Puree::REST::Client.new config
    response = client.organisational_units.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.organisational_units response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::OrganisationalUnit, data.first if !data.empty?
  end

  def test_persons
    client = Puree::REST::Client.new config
    response = client.persons.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.persons response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Person, data.first if !data.empty?
  end

  def test_projects
    client = Puree::REST::Client.new config
    response = client.projects.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.projects response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Project, data.first if !data.empty?
  end

  def test_research_outputs
    client = Puree::REST::Client.new config
    response = client.research_outputs.all params: { size: collection_size }
    data = Puree::XMLExtractor::Collection.research_outputs response.to_s

    # puts data

    assert_instance_of Hash, data

    journal_articles = data[:journal_articles]
    assert_instance_of Array, journal_articles
    assert_instance_of Puree::Model::JournalArticle, journal_articles.first if !journal_articles.empty?

    puts journal_articles.first.inspect

    assert_equal 'Journal article', journal_articles.first.type if !journal_articles.empty?

    conference_papers = data[:conference_papers]
    assert_instance_of Array, conference_papers
    assert_instance_of Puree::Model::ConferencePaper, conference_papers.first if !conference_papers.empty?
    assert_equal 'Conference paper', conference_papers.first.type if !conference_papers.empty?

    theses = data[:theses]
    assert_instance_of Array, theses
    assert_instance_of Puree::Model::Thesis, theses.first if !theses.empty?
    assert_equal 'Thesis', theses.first.type if !theses.empty?

    others = data[:other]
    assert_instance_of Array, others
    assert_instance_of Puree::Model::ResearchOutput, others.first if !others.empty?

  end

  def test_research_outputs_absence
    xml = '<foo/>'
    data = Puree::XMLExtractor::Collection.research_outputs xml

    assert_instance_of Hash, data

    journal_articles = data[:journal_articles]
    assert_instance_of Array, journal_articles
    assert_empty journal_articles

    conference_papers = data[:conference_papers]
    assert_instance_of Array, conference_papers
    assert_empty conference_papers

    theses = data[:theses]
    assert_instance_of Array, theses
    assert_empty theses

    others = data[:other]
    assert_instance_of Array, others
    assert_empty others
  end
end