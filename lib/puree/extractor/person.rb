module Puree

  module Extractor

    # Person extractor.
    #
    class Person < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Person, nil]
      def find(id)
        super id: id,
              api_resource_type: :person,
              xml_extractor_resource_type: :person
      end

      # Count of records available.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Integer]
      def count(params = {})
        record_count :person, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::Person, nil]
      def random(params = {})
        super :person, params
      end

    end

  end

end
