module Puree

  # Collection of resources
  #
  class Collection
    include Puree::Auth

    # @param resource [Symbol]
    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(resource: nil,
                   base_url: nil,
                   username: nil,
                   password: nil,
                   basic_auth: nil)
      @resource_type = resource
      @api_map = Puree::Map.new.get
      flexible_auth(base_url, username, password, basic_auth)
      @uuids = []
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

      @options = {
          basic_auth:       @basic_auth,
          latest_api:       true,
          resource_type:    @resource_type.to_sym,
          rendering:        :system,
          limit:            limit,
          offset:           offset,
          created_start:    created_start,
          created_end:      created_end,
          modified_start:   modified_start,
          modified_end:     modified_end,
          full:             full,
          instance:         instance,
          record_rendering: rendering
      }

      reset

      missing = missing_credentials
      if !missing.empty?
        missing.each do |m|
          puts "#{self.class.name}" + '#' + "#{__method__} missing #{m}"
        end
        exit
      end

      # strip any trailing slash
      @base_url = @base_url.sub(/(\/)+$/, '')

      headers = {}
      headers['Accept'] = 'application/xml'

      if @options[:basic_auth] === true
        @auth = Base64::strict_encode64(@username + ':' + @password)
        headers['Authorization'] = 'Basic ' + @auth
      end

      begin
        url = build_url
        req = HTTP.headers accept: 'application/xml'
        if @options[:basic_auth]
          req = req.auth headers['Authorization']
        end
        @response = req.get(url, params: params)

        set_content @response.body

      rescue HTTP::Error => e
        puts 'HTTP::Error '+ e.message
      end

    end


    # Count of records available for a resource type
    #
    # @return [Integer]
    def count
      @count ||= get_count
    end

    private

    def combine_metadata
      if @options[:full]
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

    def params
      query = {}

      query['rendering'] = @options[:rendering]

      if @options[:limit] >= 0
        query['window.size'] = @options[:limit]
      end

      if @options[:offset]
        query['window.offset'] = @options[:offset]
      end

      if @options[:created_start]
        query['createdDate.fromDate'] = @options[:created_start]
      end

      if @options[:created_end]
        query['createdDate.toDate'] = @options[:created_end]
      end

      if @options[:modified_start]
        query['modifiedDate.fromDate'] = @options[:modified_start]
      end

      if @options[:modified_end]
        query['modifiedDate.toDate'] = @options[:modified_end]
      end

      if @options['rendering']
        query['rendering'] = @options['rendering']
      end

      query
    end

    def get_count
      find limit: 0
      @extractor.count
    end

    # Array of UUIDs
    #
    # @return [Array<String>]
    def uuid
      @extractor.uuid
    end


    def collect_resource
      data = []
      resource_class = 'Puree::' + @resource_type.to_s.capitalize

      # whitelist symbol
      if @api_map[:resource_type].has_key?(@resource_type)
        uuid.each do |u|
          if @options[:basic_auth] === true
            r = Object.const_get(resource_class).new base_url: @base_url
            r.basic_auth username: @username,
                         password: @password
          else
            r = Object.const_get(resource_class).new base_url: @base_url
          end
          record = r.find uuid: u,
                          rendering:  @options[:record_rendering]
          if @options[:instance]
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

    def service_name
      resource_type = @options[:resource_type]
      @api_map[:resource_type][resource_type][:service]
    end

    def service_response_name
      resource_type = @options[:resource_type]
      @api_map[:resource_type][resource_type][:response]
    end

    def build_url
      service = service_name
      if @options[:latest_api] === false
        service_api_mode = service
      else
        service_api_mode = service + '.current'
      end
      @base_url + '/' + service_api_mode
    end

    def missing_credentials
      missing = []
      if @base_url.nil?
        missing << 'base_url'
      end

      if @options[:basic_auth] === true
        if @username.nil?
          missing << 'username'
        end
        if @password.nil?
          missing << 'password'
        end
      end

      missing
    end

    def reset
      @response = nil
      @count = nil
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