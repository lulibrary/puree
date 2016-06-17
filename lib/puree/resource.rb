module Puree

  # Abstract base class for resources.
  #
  class Resource
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
    # @param content [Symbol]
    # @return [Hash]
    def get(uuid: nil, id: nil)

      @options = {
          basic_auth:     @basic_auth,
          latest_api:     @latest_api,
          resource_type:  @resource_type.to_sym,
          rendering:      :xml_long,
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

      begin
        # p self.inspect
        # p build_url
        # p query
        # p headers
        @response = HTTParty.get(build_url, query: query, headers: headers, timeout: 120)

      # puts @response.code
      rescue HTTParty::Error => e
        puts 'HTTParty::Error '+ e.message
      end

      # if get_data?
        # response_name = service_response_name
        # content = @response.parsed_response[response_name]['result']['content']
        # set_content(content)
      # end

      metadata ? metadata : {}

    end

    # Response, if get method has been called
    #
    # @return [HTTParty::Response]
    # @return [Nil]
    def response
      @response ? @response : nil
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
      data = node 'created'
      !data.nil? && !data.empty? ? data.strip : ''
    end

    # Modified (UTC datetime)
    #
    # @return [String]
    def modified
      data = node 'modified'
      !data.nil? && !data.empty? ? data.strip : ''
    end

    # UUID
    #
    # @return [String]
    def uuid
      data = node 'uuid'
      !data.nil? && !data.empty? ? data.strip : ''
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


    # Node
    #
    # @return [Hash]
    def node(path)
      @content ? @content[path] : {}
    end


    # Is there any data after get? For a response that provides a count of the results.
    #
    # @return [Boolean]
    def get_data?
      response_name = service_response_name
      @response.parsed_response[response_name]['count'] != '0' ? true : false
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
      service_response_name + '/result/content/'
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