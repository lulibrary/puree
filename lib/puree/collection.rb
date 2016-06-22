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
            full:             true,
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
          record_rendering: rendering
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

      if @options['rendering']
        query['rendering'] = @options['rendering']
      end

      # @response = HTTParty.get(build_url, query: query, headers: headers)

      begin
        # p self.inspect
        # p build_url
        # p query
        # p headers
        # @response = HTTParty.get(build_url, query: query, headers: headers, timeout: 120)
        url = build_url
        req = HTTP.headers accept: 'application/xml'
        if @options[:basic_auth]
          req = req.auth headers['Authorization']
        end
        @response = req.get(url, params: query)
        @doc = Nokogiri::XML @response.body
        @doc.remove_namespaces!

        code = @response.code
        # body = @response.body
        # puts "#{self.class.name} #{code}"
          # puts "#{self.class.name} #{body}"

      rescue HTTP::Error => e
        puts 'HTTP::Error '+ e.message
      end

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
                                                 password:   @password,
                                                 basic_auth: true
      else
        r = Object.const_get(resource_class).new endpoint:   @endpoint
      end
      # whitelist symbol
      if @api_map[:resource_type].has_key?(@resource_type)
        uuid.each do |u|
          record = r.find uuid: u,
                          rendering:  @options[:record_rendering]
          # puts JSON.pretty_generate( record, :indent => '  ')
          # p u
          data << record
        end
        data
      else
        puts 'Invalid resource class'
        exit
      end
    end

    def collect_uuid
      @uuids = []
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
      @doc.xpath path
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