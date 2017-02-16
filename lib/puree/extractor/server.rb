module Puree

  module Extractor

    class Server

      attr_reader :response

      # @param base_url [String]
      # @param basic_auth [Boolean]
      def initialize(base_url:)
        @resource_type = :server
        @request = Puree::API::Request.new base_url: base_url
        @metadata = {}
      end

      def basic_auth(username:, password:)
        @request.basic_auth username: username,
                            password: password
      end

      # Get
      #
      # @return [Hash]
      def get
        reset
        @response = @request.get rendering:      :system,
                                 resource_type:  @resource_type
        set_content @response.body
      end

      # All metadata
      #
      # @return [Hash]
      def metadata
        @metadata
      end

      # Version
      #
      # @return [String]
      def version
        @metadata['version']
      end

      private

      def combine_metadata
        o = {}
        o['version'] = @extractor.version
        @metadata = o
      end

      def reset
        @response = nil
      end

      # Set content from XML. In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_extractor
          @extractor.get_data? ? combine_metadata : {}
        end
      end

      def make_extractor
        @extractor = Puree::XMLExtractor::Server.new xml: @response.body
      end

      alias :find :get

    end

  end

end

