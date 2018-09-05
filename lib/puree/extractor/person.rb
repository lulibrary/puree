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
      # @return [Fixnum]
      def count
        record_count :person
      end

      # Random record.
      #
      # @return [Puree::Model::Person, nil]
      def random
        super :person
      end

    end

  end

end
