module Puree

  module Extractor

    # Project extractor.
    #
    class Project < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :project,
                         xml_extractor_resource_type: :project
      end

      def count
        find_and_count :project
      end

    end

  end

end
