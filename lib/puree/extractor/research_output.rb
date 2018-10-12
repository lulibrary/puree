module Puree

  module Extractor

    # Research output extractor.
    #
    class ResearchOutput < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::ResearchOutput, nil]
      def find(id)
        super id: id,
              api_resource_type: :research_output,
              xml_extractor_resource_type: :research_output
      end

      # Count of records available.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Integer]
      def count(params = {})
        record_count :research_output, params
      end

      # Random record. Includes the metadata from Puree::Model::ResearchOutput as a minimum.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::ResearchOutput or subclass, nil]
      def random(params = {})
        client = Puree::REST::Client.new @config
        offset = rand(0..count(params)-1)
        params[:size] = 1
        params[:offset] = offset
        response = client.research_outputs.all_complex params: params
        research_outputs_hash = Puree::XMLExtractor::Collection.research_outputs response.to_s
        research_outputs_array = []
        research_outputs_hash.each do |k, v|
          research_outputs_array += v
        end
        return nil if research_outputs_array.empty?
        research_outputs_array[0]
      end

    end

  end

end
