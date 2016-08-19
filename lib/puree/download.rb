module Puree

  # Download
  #
  class Download
    attr_reader :response

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil,
                   username: nil,
                   password: nil,
                   basic_auth: nil)
      @resource_type = :download
      @api_map = Puree::Map.new.get
      @base_url = base_url.nil? ? Puree.base_url : base_url
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
    end

    # Get
    #
    # @param limit [Integer]
    # @param offset [Integer]
    # @param resource [Symbol]
    # @return [Array<Hash>]
    def get(limit: 20,
            offset: 0,
            resource: nil)
      missing = missing_credentials
      if !missing.empty?
        missing.each do |m|
          puts "#{self.class.name}" + '#' + "#{__method__} missing #{m}"
        end
        exit
      end

      # strip any trailing slash
      @base_url = @base_url.sub(/(\/)+$/, '')
      @auth = Base64::strict_encode64(@username + ':' + @password)

      @options = {
          basic_auth:     @basic_auth,
          latest_api:     true,
          resource_type:  @resource_type.to_sym,
          rendering:      :system,
          limit:          limit,
          offset:         offset,
          resource:       resource.to_sym
      }
      headers = {
          'Accept' => 'application/xml',
          'Authorization' => 'Basic ' + @auth
      }
      query = {}
      query['rendering'] = @options[:rendering]

      if @options[:limit]
        query['window.size'] = @options[:limit]
      end

      if @options[:offset]
        query['window.offset'] = @options[:offset]
      end

      if @options[:resource]
        query['contentType'] = service_family
      end

      begin
        url = build_url
        req = HTTP.headers accept: headers['Accept']
        if @options[:basic_auth]
          req = req.auth headers['Authorization']
        end
        @response = req.get(url, params: query)
        @doc = Nokogiri::XML @response.body
        @doc.remove_namespaces!
      rescue HTTP::Error => e
        puts 'HTTP::Error '+ e.message
      end

      get_data? ? combine_metadata : []
    end




    # All metadata
    #
    # @return [Array<Hash>]
    def metadata
      @metadata
    end


    private


    def combine_metadata
      @metadata = extract_statistic
    end

    # Is there any data after get?
    #
    # @return [Boolean]
    def get_data?
      # n.b. arbitrary element existence check
      path = service_response_name + '/downloadCount'
      xpath_result = @doc.xpath path
      xpath_result.size ? true : false
    end

    # Statistic
    #
    # @return [Array<Hash>]
    def extract_statistic
      path = service_response_name + '/downloadCount'
      xpath_result =  xpath_query path
      data_arr = []
      xpath_result.each { |i|
        data = {}
        data['uuid'] = i.attr('uuid').strip
        data['download'] = i.attr('downloads').strip
        data_arr << data
      }
      data_arr.uniq
    end

    def service_family
      resource_type = @options[:resource]
      if @api_map[:resource_type].has_key? resource_type
        @api_map[:resource_type][resource_type][:family]
      else
        puts "#{resource_type} is an unrecognised resource type"
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

    def xpath_query(path)
      xml = @response.body
      doc = Nokogiri::XML xml
      doc.remove_namespaces!
      doc.xpath path
    end

    def missing_credentials
      missing = []
      if @base_url.nil?
        missing << 'base_url'
      end
      if @username.nil?
        missing << 'username'
      end
      if @password.nil?
        missing << 'password'
      end
      missing
    end

    alias :find :get

  end
end
