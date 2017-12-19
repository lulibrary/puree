module Puree

  module Extractor

    # Person extractor.
    #
    class Person < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :person,
                         xml_extractor_resource_type: :person
      end

    end

  end

end
