module Puree

  module Extractor

    # Download extractor.
    #
    class Download
      include Puree::API::Authentication

      attr_reader :response

      # @option (see Puree::API::Authentication#configure_api)
      def initialize(config)
        @resource_type = :download
        @api_map = Puree::API::Map.new.get # Workararound to provide access to service_family
        configure_api config
      end

      # Get download statistics. Only for Datasets.
      #
      # @param limit [Fixnum]
      # @param offset [Fixnum]
      # @param resource [Symbol] The resource being reported
      # @return [Array<Puree::Model::DownloadHeader>]
      def get(limit: 0,
              offset: 0,
              resource:)
        raise 'Cannot perform a request without a configuration' if @config.nil?
        @response = @request.get rendering:      :system,
                                 limit:          limit,
                                 offset:         offset,
                                 resource_type:  @resource_type,
                                 content_type:   service_family(resource)
        set_content @response.body
      end

      private

      def combine_metadata
        @extractor.statistics
      end

      # Set content from XML. In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_extractor
          @extractor.get_data? ? combine_metadata : []
        end
      end

      def make_extractor
        @extractor = Puree::XMLExtractor::Download.new xml: @response.body
      end

      def service_family(resource_type)
        if @api_map[:resource_type].has_key? resource_type
          # Family data is only populated for datasets (required for download)
          @api_map[:resource_type][resource_type][:family]
        else
          raise "#{resource_type} is an unrecognised resource type"
        end
      end

      alias :find :get

    end

  end

end
