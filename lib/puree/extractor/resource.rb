module Puree

  module Extractor

    class Resource

      attr_reader :metadata, :response

      # @param url [String]
      # @param bleeding [Boolean]
      def initialize(url:, bleeding: true)
        @latest_api = bleeding
        @request = Puree::API::Request.new url: url
        @metadata = nil
      end

      def basic_auth(username:, password:)
        @request.basic_auth username: username,
                            password: password
      end

      # Get
      #
      # @param uuid [String]
      # @param id [String]
      # @return [Struct] Resource metadata e.g. Puree::Model::Dataset
      def get(uuid: nil, id: nil, rendering: :xml_long)
        reset
        @response = @request.get uuid:           uuid,
                                 id:             id,
                                 rendering:      rendering,
                                 latest_api:     @latest_api,
                                 resource_type:  @resource_type
        set_content @response.body
      end

      # Set content from XML. In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_xml_extractor
          @extractor.get_data? ? combine_metadata : {}
        end
      end

      private

      def setup(resource)
        @resource_type = resource
        resource_class = "Puree::Model::#{resource.to_s.capitalize}"
        @model = Object.const_get(resource_class).new
      end

      def make_xml_extractor
        resource_class = "Puree::XMLExtractor::#{@resource_type.to_s.capitalize}"
        @extractor = Object.const_get(resource_class).new xml: @response.body
      end

      # All metadata
      # @return [Hash]
      def combine_metadata
        @model.uuid = @extractor.uuid
        @model.created = @extractor.created
        @model.modified = @extractor.modified
        @model.locale = @extractor.locale
      end

      def reset
        @response = nil
      end

      alias :find :get

    end

  end

end