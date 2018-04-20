module Puree

  module Extractor

    # Person extractor.
    #
    class Person < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Person, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :person,
                         xml_extractor_resource_type: :person
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :person
      end

    end

  end

end
