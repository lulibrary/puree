module Puree

  module Extractor

    # Project extractor.
    #
    class Project < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Project, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :project,
                         xml_extractor_resource_type: :project
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :project
      end

      # Random resource.
      #
      # @return [Puree::Model::Project, nil]
      def random
        super :project
      end

    end

  end

end
