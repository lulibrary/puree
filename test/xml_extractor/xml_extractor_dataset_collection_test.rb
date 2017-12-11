require 'test_helper'

class TestXMLExtractorDatasetCollection < Minitest::Test

  def test_models
    client = Purification::Client.new config
    response = client.persons.all params: { size: 10 }
    data = Puree::XMLExtractor::DatasetCollection.models xml: response.to_s

    assert_instance_of Array, data
    assert_instance_of Puree::Model::Dataset, data.first if !data.empty?
  end

  def test_absence
    xml = '<foo/>'
    data = Puree::XMLExtractor::DatasetCollection.models xml: xml

    assert_instance_of Array, data
    assert_empty data
  end
end