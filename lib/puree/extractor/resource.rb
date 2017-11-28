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


      # Set content from XML.
      #
      # @param xml [String]
      def extract(xml)
        if xml
          make_xml_extractor xml
          combine_metadata
          # @extractor.get_data? ? combine_metadata : nil
        end
      end

      private

      # For specialised extraction such as Publication subtypes e.g. doctoral_thesis
      def set_model_type(type)
        @model_type = type
      end

      def setup(resource)
        @resource_type = resource
        if @model_type
          resource_class = "Puree::Model::#{Puree::Util::String.titleize(@model_type)}"
        else
          resource_class = "Puree::Model::#{Puree::Util::String.titleize(resource)}"
        end
        @model = Object.const_get(resource_class).new
      end

      def make_xml_extractor xml
        if @model_type
          resource_class = "Puree::XMLExtractor::#{Puree::Util::String.titleize(@model_type)}"
        else
          resource_class = "Puree::XMLExtractor::#{Puree::Util::String.titleize(@resource_type)}"
        end
        @extractor = Object.const_get(resource_class).new xml: xml
      end

      # All metadata
      # @return [Hash]
      def combine_metadata
        @model.uuid = @extractor.uuid
        @model.created_by = @extractor.created_by
        @model.created_at = @extractor.created_at
        @model.modified_by = @extractor.modified_by
        @model.modified_at = @extractor.modified_at
        # @model.locale = @extractor.locale
      end

      alias :find :get

    end

  end

end