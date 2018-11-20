require 'test_xml_extractor_helper'

class TestXMLExtractorEncoder < Minitest::Test
  def test_encode_doi
    xml = '<somexml><doi>http://bbc.co.uk/3/f/foo&lt;bar>lol</doi></somexml>'
    encoded_xml = Puree::XMLExtractor::Encoder.encode_doi xml

    to_replace = '&lt;'
    replacement = 'puree_lt'
    assert_equal 0, encoded_xml.scan(/#{to_replace}/).length
    assert_equal 1, encoded_xml.scan(/#{replacement}/).length
  end

  def test_decode_doi

  end
end