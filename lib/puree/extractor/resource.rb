module Puree

  module Extractor

    # Resource extractor.
    #
    class Resource
      include Puree::API::Authentication

      # @option (see Puree::API::Authentication#configure_api)
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
      def get(uuid: nil, id: nil)
        raise 'Cannot perform a request without a configuration' if @config.nil?
        @response = @request.get uuid:           uuid,
                                 id:             id,
                                 latest_api:     @latest_api,
                                 resource_type:  @resource_type
        set_content @response.body
      end

      private

      # Set content from XML.
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_xml_extractor xml
          @extractor.get_data? ? combine_metadata : nil
        end
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