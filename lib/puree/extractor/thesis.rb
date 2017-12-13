module Puree
  module Extractor

    # Thesis extractor.
    #
    class Thesis < Puree::Extractor::Publication

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
      end

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :thesis
      end

    end

  end
end
