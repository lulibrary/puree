module Puree

  # Abstract base class for resources.
  #
  class Resource

    attr_reader :response

    # @param api [String]
    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional bleeding [Boolean]
    # @param optional basic_auth [Boolean]
    def initialize( api: nil,
                    endpoint: nil,
                    username: nil,
                    password: nil,
                    bleeding: true,
                    basic_auth: nil)
      @resource_type = api
      @api_map = Puree::Map.new.get
      @endpoint = endpoint.nil? ? Puree.endpoint : endpoint
      @latest_api = bleeding
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
    end

    # Get
    #
    # @param uuid [String]
    # @param id [String]
    # @return [Hash]
    def get(uuid: nil, id: nil, rendering: :xml_long)
      reset

      @options = {
          basic_auth:     @basic_auth,
          latest_api:     @latest_api,
          resource_type:  @resource_type.to_sym,
          rendering:      rendering,
          uuid:           uuid,
          id:             id
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

      if @options[:uuid]
        query['uuids.uuid'] = @options[:uuid]
      else
        if @options[:id]
          query['pureInternalIds.id'] = @options[:id]
        end
      end

      if @options['rendering']
        query['rendering'] = @options['rendering']
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

      get_data? ? metadata : {}

    end

    # Set content
    #
    # @param content [Hash]
    def set_content(content)
      if !content.nil? && !content.empty?
        @content = content
      else
        @content = {}
      end
    end

    # Content
    #
    # @return [Hash]
    def content
      @content ? @content : {}
    end

    # Created (UTC datetime)
    #
    # @return [String]
    def created
      path = '/created'
      xpath_query_for_single_value path
    end

    # Modified (UTC datetime)
    #
    # @return [String]
    def modified
      path = '/modified'
      xpath_query_for_single_value path
    end

    # UUID
    #
    # @return [String]
    def uuid
      path = '/@uuid'
      xpath_query_for_single_value path
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = {}
      o['uuid'] = uuid
      o['created'] = created
      o['modified'] = modified
      o
    end



    private


    # Is there any data after get? For a response that provides a count of the results.
    #
    # @return [Boolean]
    def get_data?
      path = service_xpath_count
      xpath_result = @doc.xpath path
      xpath_result.text.strip === '1' ? true : false
    end

    def service_name
      resource_type = @options[:resource_type]
      @api_map[:resource_type][resource_type][:service]
    end

    def service_response_name
      resource_type = @options[:resource_type]
      @api_map[:resource_type][resource_type][:response]
    end

    def service_xpath_base
      service_response_name + '/result/content'
    end

    def service_xpath_count
      service_response_name + '/count'
    end

    def service_xpath(str_to_find)
      service_xpath_base + str_to_find
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

    # content based
    def xpath_query(path)
      path_from_root = service_xpath path
      @doc.xpath path_from_root
    end

    def xpath_query_for_single_value(path)
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
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

    def reset
      @response = nil
    end

    alias :find :get

  end
end