module Puree

  module Extractor

    # Server extractor.
    #
    class Server

      attr_reader :response

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        @resource_type = :server
        configure_api config
      end

      # Get server information.
      #
      # @return [Puree::Model::Server, nil]
      def get
        raise 'Cannot perform a request without a configuration' if @config.nil?
        @response = @request.get resource_type: @resource_type
        set_content @response.body
      end

      private

      # Configure a Pure host for API access.
      #
      # @param config [Hash]
      def configure_api(config)
        @config = Puree::API::Configuration.new url: config[:url]
        @config.basic_auth username: config[:username],
                           password: config[:password]

        @request = Puree::API::Request.new url: @config.url
        if @config.basic_auth?
          @request.basic_auth username: @config.username,
                              password: @config.password
        end
      end

      def combine_metadata
        model = Puree::Model::Server.new
        model.version = @extractor.version
        model
      end

      # Set content from XML. In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints
      #
      # @param xml [String]
      # @return [Puree::Model::Server, nil]
      def set_content(xml)
        if xml
          make_extractor
          @extractor.get_data? ? combine_metadata : nil
        end
      end

      def make_extractor
        @extractor = Puree::XMLExtractor::Server.new xml: @response.body
      end

      alias :find :get

    end

  end

end

