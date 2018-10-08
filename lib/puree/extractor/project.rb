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
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Fixnum]
      def count(params = {})
        record_count :project, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::Project, nil]
      def random(params = {})
        super :project, params
      end

    end

  end

end
