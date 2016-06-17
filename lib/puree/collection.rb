module Puree

  # Collection of resources
  #
  class Collection

    # @param resource [Symbol]
    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional basic_auth [Boolean]
    def initialize(resource: nil,
                   endpoint: nil,
                   username: nil,
                   password: nil,
                   basic_auth: nil)
      @resource_type = resource
      @api_map = Puree::Map.new.get
      @endpoint = endpoint.nil? ? Puree.endpoint : endpoint
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
      @uuids = []
    end

    # Gets an array of objects of resource type specified in constructor
    #
    # @param optional limit [Integer]
    # @param optional offset [Integer]
    # @param optional created_start [String]
    # @param optional created_end [String]
    # @param optional modified_start [String]
    # @param optional modified_end [String]
    # @param optional full [Boolean]
    # @return [Array<Object>]
    def get(
            limit:            20,
            offset:           0,
            created_start:    nil,
            created_end:      nil,
            modified_start:   nil,
            modified_end:     nil,
            full:             true
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
          full:             full
      }

      missing = missing_credentials
      if !missing.empty?
        missing.each do |m|
          puts "#{self.class.name}" + '#' + "#{__method__} missing #{m}"
        end
        exit
      end

      # strip any trailing slash
      @endpoint = @endpoint.sub(/(\/)+$/, '')

      headers = {}
      headers['Accept'] = 'application/xml'

      if @options[:basic_auth] === true
        @auth = Base64::strict_encode64(@username + ':' + @password)
        headers['Authorization'] = 'Basic ' + @auth
      end

      query = {}

      query['rendering'] = @options[:rendering]

      if @options[:limit]
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

      @response = HTTParty.get(build_url, query: query, headers: headers)

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


    private


    # Array of UUIDs
    #
    # @return [Array<String>]
    def uuid
      collect_uuid
      @uuids
    end


    def collect_resource
      data = []
      resource_class = 'Puree::' + @resource_type.to_s.capitalize

      if @options[:basic_auth] === true
        r = Object.const_get(resource_class).new endpoint:   @endpoint,
                                                 username:   @username,
                                                 password:   @password
      else
        r = Object.const_get(resource_class).new endpoint:   @endpoint,
                                                 basic_auth: false
      end
      # whitelist symbol
      if @api_map[:resource_type].has_key?(@resource_type)
        uuid.each do |u|
          record = r.find uuid: u
          # puts record
          data << record
        end
        data
      else
        puts 'Invalid resource class'
        exit
      end
    end

    def collect_uuid
      path = '//renderedItem/@renderedContentUUID'
      xpath_result = xpath_query path
      xpath_result.each { |i| @uuids << i.text.strip }
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
      @endpoint + '/' + service_api_mode
    end

    def xpath_query(path)
      xml = @response.body
      doc = Nokogiri::XML xml
      doc.remove_namespaces!
      doc.xpath path
    end

    def missing_credentials
      missing = []
      if @endpoint.nil?
        missing << 'endpoint'
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

    alias :find :get

  end
end