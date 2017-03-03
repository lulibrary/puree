module Puree

  module Extractor

    # Resource extractor
    #
    class Resource

      attr_reader :response

      # @param url [String]
      # @param bleeding [Boolean]
      def initialize(url:, bleeding: true)
        @latest_api = bleeding
        @request = Puree::API::Request.new url: url
      end

      # Provide credentials if necessary
      #
      # @param username [String]
      # @param password [String]
      def basic_auth(username:, password:)
        @request.basic_auth username: username,
                            password: password
      end

      # Get a resource.
      #
      # @param uuid [String]
      # @param id [String]
      # @return [Puree::Model::Resource subclass] Resource metadata e.g. Puree::Model::Dataset
      def get(uuid: nil, id: nil, rendering: :xml_long)
        @response = @request.get uuid:           uuid,
                                 id:             id,
                                 rendering:      rendering,
                                 latest_api:     @latest_api,
                                 resource_type:  @resource_type
        set_content @response.body
      end

      # Set content from XML.
      # In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints.
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_xml_extractor xml
          @extractor.get_data? ? combine_metadata : {}
        end
      end

      # Set content from XML in a file.
      # In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints.
      #
      # @param path [String]
      def from_file(path)
        set_content File.read path
      end

      private

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