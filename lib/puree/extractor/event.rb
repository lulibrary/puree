module Puree

  module Extractor

    # Event extractor.
    #
    class Event < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :event,
                         xml_extractor_resource_type: :event
      end

      def count
        find_and_count :event
      end

    end

  end

end
