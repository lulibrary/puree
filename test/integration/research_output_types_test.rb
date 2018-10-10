require 'test_rest_helper'

class TestResearchOutputTypes < Minitest::Test

  def types
    [
      {
        uri: '/dk/atira/pure/researchoutput/researchoutputtypes/contributiontojournal/article',
        text: 'Journal article',
        xml_extractor_key: :journal_articles
      },
      {
        uri: '/dk/atira/pure/researchoutput/researchoutputtypes/contributiontoconference/paper',
        text: 'Conference paper',
        xml_extractor_key: :conference_papers
      }
    ]
  end

  def test_types
    size = 10

    types.each do |type|
      params = {
        size: size,
        typeUri: [type[:uri]]
      }
      response = client.research_outputs.all_complex params: params
      # puts response

      assert_equal response.code, 200
      assert_instance_of HTTP::Response, response

      typed_model_hash = Puree::XMLExtractor::Collection.research_outputs response.to_s
      type_key = type[:xml_extractor_key]

      # Number of models should not be more than expected for specific type
      assert typed_model_hash[type_key].size <= size

      # Number of models should not be more than expected across all types
      model_total = 0
      typed_model_hash.each do |k, v|
        model_total += v.size
      end
      assert model_total <= size

      # Model placed in correct hash key
      typed_model_hash.each do |k, v|
        v.each do |model|
          assert_equal type[:text], model.type
        end
      end
    end
  end

end