module Puree

  module Extractor

    class Download

      attr_reader :response

      # @param base_url [String]
      def initialize(base_url:)
        @resource_type = :download
        @request = Puree::API::Request.new base_url: base_url
        @api_map = Puree::API::Map.new.get # Workararound to provide access to service_family
        @metadata = {}
      end

      def basic_auth(username:, password:)
        @request.basic_auth username: username,
                            password: password
      end

      # Get
      #
      # @param limit [Integer]
      # @param offset [Integer]
      # @param resource [Symbol] The resource being reported
      # @return [Array<Hash>]
      def get(limit: 20,
              offset: 0,
              resource:)
        reset
        @response = @request.get rendering:      :system,
                                 limit:          limit,
                                 offset:         offset,
                                 resource_type:  @resource_type,
                                 content_type:   service_family(resource)
        set_content @response.body
      end

      # All metadata
      #
      # @return [Array<Hash>]
      def metadata
        @metadata
      end


      private

      def combine_metadata
        @metadata = @extractor.statistic
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
