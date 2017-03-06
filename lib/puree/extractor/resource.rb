module Puree

  module Extractor

    # Resource extractor
    #
    class Resource

      attr_reader :response

      # @param config [Hash]
      # @option config [String] :url The URL of the Pure host.
      # @option config [String] :username The username of the Pure host account.
      # @option config [String] :password The password of the Pure host account.
      # @param bleeding [Boolean]
      def initialize(config, bleeding: true)
        @latest_api = bleeding
        configure_api config
      end

      # Get a resource.
      #
      # @param uuid [String]
      # @param id [String]
      # @return [Puree::Model::Resource subclass, nil] Resource metadata e.g. Puree::Model::Dataset
      def get(uuid: nil, id: nil, rendering: :xml_long)
        raise 'Cannot perform a request without a configuration' if @config.nil?
        @response = @request.get uuid:           uuid,
                                 id:             id,
                                 rendering:      rendering,
                                 latest_api:     @latest_api,
                                 resource_type:  @resource_type
        set_content @response.body
      end

      # Set content from XML.
      # In order for metadata extraction to work, with the exception of Project,
      # the XML must have been retrieved using the .current version of the Pure
      # API endpoints.
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_xml_extractor xml
          @extractor.get_data? ? combine_metadata : nil
        end
      end

      # Set content from XML in a file.
      # In order for metadata extraction to work, with the exception of Project,
      # the XML must have been retrieved using the .current version of the Pure
      # API endpoints.
      #
      # @param path [String]
      def from_file(path)
        set_content File.read path
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

      def setup_request
      end

      def setup(resource)
        @resource_type = resource
        resource_class = "Puree::Model::#{resource.to_s.capitalize}"
        @model = Object.const_get(resource_class).new
      end

      def make_xml_extractor xml
        resource_class = "Puree::XMLExtractor::#{@resource_type.to_s.capitalize}"
        @extractor = Object.const_get(resource_class).new xml: xml
      end

      # All metadata
      # @return [Hash]
      def combine_metadata
        @model.uuid = @extractor.uuid
        @model.created = @extractor.created
        @model.modified = @extractor.modified
        @model.locale = @extractor.locale
      end

      alias :find :get

    end

  end

end