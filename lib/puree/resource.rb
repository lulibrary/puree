module Puree

  # Abstract base class for resources.
  #
  class Resource

    attr_reader :response

    # @param api [String]
    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param bleeding [Boolean]
    # @param basic_auth [Boolean]
    def initialize( api: nil,
                    base_url: nil,
                    username: nil,
                    password: nil,
                    bleeding: true,
                    basic_auth: nil)
      @resource_type = api
      @api_map = Puree::Map.new.get
      @base_url = base_url.nil? ? Puree.base_url : base_url
      @latest_api = bleeding
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
      @metadata = {}
      @options = {
          basic_auth:     @basic_auth,
          latest_api:     @latest_api,
          resource_type:  @resource_type.to_sym
      }
    end

    # Get
    #
    # @param uuid [String]
    # @param id [String]
    # @return [Hash]
    def get(uuid: nil, id: nil, rendering: :xml_long)
      reset

      @options[:rendering] = rendering
      @options[:uuid] = uuid
      @options[:id] = id

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

      query = {}
      query['rendering'] = @options[:rendering]

      if @options[:uuid]
        query['uuids.uuid'] = @options[:uuid]
      else
        if @options[:id]
          query['pureInternalIds.id'] = @options[:id]
        end
      end

      if @options[:rendering]
        query['rendering'] = @options[:rendering]
      end

      begin
        url = build_url
        req = HTTP.headers accept: headers['Accept']
        if @options[:basic_auth]
          req = req.auth headers['Authorization']
        end
        @response = req.get(url, params: query)
        make_doc @response.body

      rescue HTTP::Error => e
        puts 'HTTP::Error '+ e.message
      end

      get_data? ? combine_metadata : {}

    end

    # UUID
    #
    # @return [String]
    def uuid
      @metadata['uuid']
    end

    # Created (UTC datetime)
    #
    # @return [String]
    def created
      @metadata['created']
    end

    # Modified (UTC datetime)
    #
    # @return [String]
    def modified
      @metadata['modified']
    end

    # Set content from XML. In order for metadata extraction to work, the XML must have
    # been retrieved using the .current version of the Pure API endpoints
    #
    # @param xml [String]
    def set_content(xml)
      if xml
        make_doc xml
        if get_data?
          combine_metadata
        end
      end
    end

    private

    def make_doc(xml)
      @doc = Nokogiri::XML xml
      @doc.remove_namespaces!
    end

    def extract_created
      path = '/created'
      xpath_query_for_single_value path
    end

    def extract_modified
      path = '/modified'
      xpath_query_for_single_value path
    end

    def extract_uuid
      path = '/@uuid'
      xpath_query_for_single_value path
    end

    # All metadata
    #
    # @return [Hash]
    def combine_metadata
      o = {}
      o['uuid'] = extract_uuid
      o['created'] = extract_created
      o['modified'] = extract_modified
      o
    end

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
      @base_url + '/' + service_api_mode
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
    end

    alias :find :get


  end
end