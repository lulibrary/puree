module Puree

  module Extractor

    # Event extractor.
    #
    class Event < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Event, nil]
      def find(id)
        super id: id,
              api_resource_type: :event,
              xml_extractor_resource_type: :event
      end

      # Count of records available.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Fixnum]
      def count(params = {})
        record_count :event, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::Event, nil]
      def random(params = {})
        super :event, params
      end

    end

  end

end
