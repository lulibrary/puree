module Puree

  module Extractor

    # Resource extractor.
    #
    class Resource

      # @param config [Hash]
      # @option config [String] :url URL of the Pure host
      # @option config [String] :username Username of the Pure host account
      # @option config [String] :password Password of the Pure host account
      # @option config [String] :api_key API key of the Pure host account
      def initialize(config)
        @config = config
      end

      private

      # @param id [String]
      # @param api_resource_type [Symbol]
      # @param xml_extractor_resource_type [Symbol]
      def find_and_extract(id:, api_resource_type:, xml_extractor_resource_type:)
        api_resource = make_api_resource api_resource_type
        response = api_resource.find id: id
        return unless response.code === 200
        xml_extractor = make_xml_extractor response.body, xml_extractor_resource_type
        xml_extractor.model
      end

      def make_api_resource(resource_type)
        resource_class = "Purist::Resource::#{Puree::Util::String.titleize(resource_type)}"
        Object.const_get(resource_class).new @config
      end

      def make_xml_extractor(xml, resource_type)
        resource_class = "Purification::XMLExtractor::#{Puree::Util::String.titleize(resource_type)}"
        Object.const_get(resource_class).new xml: xml
      end


    end

  end

end