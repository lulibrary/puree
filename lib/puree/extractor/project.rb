module Puree

  module Extractor

    # Project extractor.
    #
    class Project < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Project, nil]
      def find(id)
        super id: id,
              api_resource_type: :project,
              xml_extractor_resource_type: :project
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        record_count :project
      end

      # Random record.
      #
      # @return [Puree::Model::Project, nil]
      def random
        super :project
      end

    end

  end

end
