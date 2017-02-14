module Puree

  # Collection of resources
  #
  class Collection

    # @param base_url [String]
    # @param resource [Symbol]
    def initialize(base_url:, resource: nil)
      @base_url = base_url
      @resource_type = resource
      @request = Puree::Request.new base_url: base_url
      @api_map = Puree::Map.new.get
    end

    def basic_auth(username:, password:)
      @request.basic_auth username: username,
                          password: password
      @basic_auth = true
    end

    # Gets an array of objects of resource type specified in constructor
    #
    # @param limit [Integer]
    # @param offset [Integer]
    # @param created_start [String]
    # @param created_end [String]
    # @param modified_start [String]
    # @param modified_end [String]
    # @param full [Boolean]
    # @param instance [Boolean]
    # @return [Array<Object>]
    # @return [Array<Resource subclass>]
    def get(
            limit:            20,
            offset:           0,
            created_start:    nil,
            created_end:      nil,
            modified_start:   nil,
            modified_end:     nil,
            full:             true,
            instance:         false,
            rendering:        :xml_long
    )
      reset
      @full = full
      @instance = instance
      @record_rendering = rendering
      @response = @request.get rendering:       :system,
                               limit:           limit,
                               offset:           offset,
                               resource_type:    @resource_type,
                               created_start:    created_start,
                               created_end:      created_end,
                               modified_start:   modified_start,
                               modified_end:     modified_end
      set_content @response.body
    end


    # Count of records available for a resource type
    #
    # @return [Integer]
    def count
      @count ||= get_count
    end

    private

    def combine_metadata
      if @full
        collect_resource
      else
        data = []
        uuid.each do |u|
          o = {}
          o['uuid'] = u
          data << o
        end
        data
      end
    end

    def get_count
      find limit: 0
      @extractor.count
    end

    # Array of UUIDs
    #
    # @return [Array<String>]
    def uuid
      @uuids ||= @extractor.uuid
    end

    def collect_resource
      data = []
      resource_class = 'Puree::' + @resource_type.to_s.capitalize

      # whitelist symbol
      if @api_map[:resource_type].has_key?(@resource_type)
        uuid.each do |u|
          r = Object.const_get(resource_class).new base_url: @base_url
          if @basic_auth === true
            r.basic_auth username: @username,
                         password: @password
          end
          record = r.find uuid: u,
                          rendering:  @record_rendering
          if @instance
            data << r
          else
            # just the data
            data << record
          end
        end
        data
      else
        puts 'Invalid resource class'
        exit
      end
    end

    def reset
      @response = nil
      @count = nil
      @uuids = nil
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
      @extractor = Puree::Extractor::CollectionExtractor.new xml: @response.body
    end

    alias :find :get

  end
end