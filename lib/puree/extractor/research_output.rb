module Puree

  module Extractor

    # Research output extractor.
    #
    class ResearchOutput < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::ResearchOutput, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :research_output
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :research_output
      end

      # Random resource.
      #
      # @return [Puree::Model::ResearchOutput or more specific type, nil]
      def random
        client = Puree::REST::Client.new @config
        offset = rand(0..count-1)
        response = client.research_outputs.all params: {size: 1, offset: offset}
        research_outputs_hash = Puree::XMLExtractor::Collection.research_outputs response.to_s
        research_outputs_array = []
        research_outputs_hash.each do |k, v|
          research_outputs_array += v
        end
        research_outputs_array[0]
      end

    end

  end

end
