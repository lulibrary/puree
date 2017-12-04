require 'test_helper'

class TestXMLExtractorResearchOutputTypeIdentification < Minitest::Test

  def test_identify
    client = Purification::Client.new config
    response = client.research_outputs.all params: { size: 10}
    xml = response.to_s
    # xml = '<foo/>'
    x = Puree::XMLExtractor::Publication.new xml: xml
    res = x.classify xml

    puts res[:journal_article].size
    puts res[:paper].size
    puts res[:thesis].size
    puts res[:other].size

    # puts outputs[:journal_article].first.inspect
    # puts outputs[:paper].first.inspect
    # puts res.inspect
    # puts outputs[:thesis].inspect
    # puts outputs[:other].first.inspect

  end

  def test_handle_single_record
    client = Purification::Client.new config
    response = client.datasets.find id: 'b050f4b5-e272-4914-8cac-3bdc1e673c58'
    xml = '<foo/>'
    x = Puree::Extractor::Dataset.new config
    xml = response.to_s
    res = x.extract xml
    assert_instance_of Puree::Model::Dataset, res
    puts res
  end

  def test_handle_multiple_records
    client = Purification::Client.new config
    response = client.datasets.all params: { size: 3}
    xml = '<foo/>'
    x = Puree::Extractor::Dataset.new config
    xml = response.to_s
    res = x.extract xml
    puts res
  end

end