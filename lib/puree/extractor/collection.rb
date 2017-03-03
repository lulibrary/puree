module Puree

  module Extractor

    # A collection extractor can retrieve any number of resources of the same type.
    #
    class Collection

      attr_reader :response

      # @param url [String]
      # @param resource [Symbol]
      def initialize(url:, resource:)
        @url = url
        @resource_type = resource
        @request = Puree::API::Request.new url: url
        @api_map = Puree::API::Map.new.get
      end

      # Provide credentials if necessary.
      #
      # @param username [String]
      # @param password [String]
      def basic_auth(username:, password:)
        @request.basic_auth username: username,
                            password: password
        @username = username
        @password = password
        @basic_auth = true
      end

      # Gets an array of objects of resource type specified in constructor.
      #
      # @param limit [Fixnum]
      # @param offset [Fixnum]
      # @param created_start [String]
      # @param created_end [String]
      # @param modified_start [String]
      # @param modified_end [String]
      # @return [Array<Puree::Model::Resource subclass>] Resource metadata e.g. Puree::Model::Dataset
      def get(
              limit:            0,
              offset:           0,
              created_start:    nil,
              created_end:      nil,
              modified_start:   nil,
              modified_end:     nil
      )
        @response = @request.get rendering:        :system,
                                 limit:            limit,
                                 offset:           offset,
                                 resource_type:    @resource_type,
                                 created_start:    created_start,
                                 created_end:      created_end,
                                 modified_start:   modified_start,
                                 modified_end:     modified_end
        set_content @response.body
      end

      # Gets a random resource of type specified in constructor.
      #
      # @return [Puree::Model::Resource subclass, nil] Resource metadata e.g. Puree::Model::Dataset
      def random_resource
        @response = @request.get rendering:        :system,
                                 limit:            1,
                                 offset:           rand(0..count-1),
                                 resource_type:    @resource_type
        content = set_content @response.body
        content[0] if content
      end


      # Count of records available for a resource type.
      #
      # @return [Fixnum]
      def count
        get_count
      end

      private

      # Array of UUIDs (from system response)
      #
      # @return [Array<String>]
      def uuids
        @extractor.uuids
      end

      def combine_metadata
        collect_resources
      end

      def get_count
        @response = @request.get resource_type: @resource_type,
                                 rendering: :system
        make_xml_extractor
        @extractor.count
      end

      def collect_resources
        data = []
        resource_class = "Puree::Extractor::#{@resource_type.to_s.capitalize}"

        # whitelist symbol
        if @api_map[:resource_type].has_key?(@resource_type)
          uuids.each do |u|
            r = Object.const_get(resource_class).new url: @url
            if @basic_auth === true
              r.basic_auth username: @username,
                           password: @password
            end
            record = r.find uuid: u,
                            rendering: :xml_long
            data << record
          end
          data
        else
          raise 'Invalid resource class'
        end
      end

      # Set content from XML. In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints
      #
      # @param xml [String]
      def set_content(xml)
        if xml
          make_xml_extractor
          @extractor.get_data? ? combine_metadata : nil
        end
      end

      def make_xml_extractor
        @extractor = Puree::XMLExtractor::Collection.new xml: @response.body
      end

      alias :find :get

    end

  end

end