module Puree

  # Server
  #
  class Server

    attr_reader :response

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional basic_auth [Boolean]
    def initialize(endpoint: nil,
                   username: nil,
                   password: nil,
                   basic_auth: nil)
      @resource_type = :server
      @api_map = Puree::Map.new.get
      @endpoint = endpoint.nil? ? Puree.endpoint : endpoint
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
    end

    # Get
    #
    # @return [Hash]
    def get
      missing = missing_credentials
      if !missing.empty?
        missing.each do |m|
          puts "#{self.class.name}" + '#' + "#{__method__} missing #{m}"
        end
        exit
      end

      # strip any trailing slash
      @endpoint = @endpoint.sub(/(\/)+$/, '')
      @auth = Base64::strict_encode64(@username + ':' + @password)

      @options = {
          basic_auth:     @basic_auth,
          latest_api:     true,
          resource_type:  @resource_type.to_sym,
          rendering:      :system,
      }
      headers = {
          'Accept' => 'application/xml',
          'Authorization' => 'Basic ' + @auth
      }
      query = {}
      query['rendering'] = @options[:rendering]

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

      get_data? ? metadata : {}
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = {}
      o['version'] = version
      o
    end

    # Version
    #
    # @return [String]
    def version
      path = service_response_name + '/baseVersion'
      xpath_query(path).text.strip
    end

    private


    # Is there any data after get?
    #
    # @return [Boolean]
    def get_data?
      # n.b. arbitrary element existence check
      path = service_response_name + '/baseVersion'
      xpath_result = @doc.xpath path
      xpath_result.size ? true : false
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

