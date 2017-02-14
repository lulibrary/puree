module Puree

  # Extractor
  #
  module Extractor

    # Server extractor
    #
    class Server < Puree::Extractor::Base

      def initialize(xml:)
        @resource_type = :server
        super
      end

      def version
        path = "#{service_response_name}/baseVersion"
        @doc.xpath(path).text.strip
      end

      # Is there any data after get?
      #
      # @return [Boolean]
      def get_data?
        # n.b. arbitrary element existence check
        version.size ? true : false
      end

    end

  end

end