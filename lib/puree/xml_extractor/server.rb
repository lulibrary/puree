module Puree

  module XMLExtractor

    # Server XML extractor.
    #
    class Server < Puree::XMLExtractor::Base

      def initialize(xml:)
        @resource_type = :server
        super
      end

      # @return [String]
      def version
        path = "#{service_response_name}/baseVersion"
        @doc.xpath(path).text.strip
      end

      # Is there any data after get?
      #
      # @return [Boolean]
      def get_data?
        # n.b. arbitrary element existence check
        version.empty? ? false : true
      end

    end

  end

end