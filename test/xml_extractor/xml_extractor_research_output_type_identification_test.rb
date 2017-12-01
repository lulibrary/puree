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

end