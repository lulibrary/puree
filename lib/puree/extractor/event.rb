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
      # @return [Fixnum]
      def count
        record_count :event
      end

      # Random record.
      #
      # @return [Puree::Model::Event, nil]
      def random
        super :event
      end

    end

  end

end
