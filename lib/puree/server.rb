module Puree

  # Server
  #
  class Server

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil)
      @resource_type = :server
      @api_map = Puree::Map.new.get
      @endpoint = endpoint.nil? ? Puree.endpoint : endpoint
      @username = username.nil? ? Puree.username : username
      @password = password.nil? ? Puree.password : password
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
        @response = HTTParty.get(build_url, query: query, headers: headers, timeout: 120)
      rescue HTTParty::Error => e
        puts 'HTTParty::Error '+ e.message
      end

      # if result and content are used as elements in response
      response_name = service_response_name
      if @response.parsed_response[response_name].has_key? 'result'
        result = @response.parsed_response[response_name]['result']
        if result.has_key? 'content'
          if get_data?
            content = @response.parsed_response[response_name]['result']['content']
            set_content(content)
          end
        end
      end

      metadata ? metadata : {}
    end



    # All metadata

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
      path = '//baseVersion'
      xpath_query(path).text.strip
    end

    private



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

