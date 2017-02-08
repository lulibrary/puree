module Puree

  # Collection of resources
  #
  class Collection

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
      @base_url = base_url.nil? ? Puree.base_url : base_url
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
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
        @doc = Nokogiri::XML @response.body
        @doc.remove_namespaces!

        @count = extract_count

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


    # Count of records available for a resource type
    #
    # @return [Integer]
    def count
      @count ||= get_count
    end

    private

    def params
      query = {}
      query['rendering'] = @options[:rendering]
      query['window.size'] = @options[:limit]
      query['window.offset'] = @options[:offset]
      query['createdDate.fromDate'] = @options[:created_start]
      query['createdDate.toDate'] = @options[:created_end]
      query['modifiedDate.fromDate'] = @options[:modified_start]
      query['modifiedDate.toDate'] = @options[:modified_end]
      query
    end

    def get_count
      find limit: 0
      extract_count
    end

    def extract_count
      path = '//count'
      xpath_query_for_single_value(path).to_i
    end


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

      # whitelist symbol
      if @api_map[:resource_type].has_key?(@resource_type)
        uuid.each do |u|
          if @options[:basic_auth] === true
            r = Object.const_get(resource_class).new base_url:   @base_url,
                                                     username:   @username,
                                                     password:   @password,
                                                     basic_auth: true
          else
            r = Object.const_get(resource_class).new base_url:   @base_url
          end
          record = r.find uuid: u,
                          rendering:  @options[:record_rendering]
          # puts JSON.pretty_generate( record, :indent => '  ')
          # p u
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
      @base_url + '/' + service_api_mode
    end

    def xpath_query(path)
      @doc.xpath path
    end

    def xpath_query_for_single_value(path)
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
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

    alias :find :get

  end
end