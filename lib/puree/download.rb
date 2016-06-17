module Puree

  # Download
  #
  class Download
    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil)
      @resource_type = :download
      @api_map = Puree::Map.new.get
      @endpoint = endpoint.nil? ? Puree.endpoint : endpoint
      @username = username.nil? ? Puree.username : username
      @password = password.nil? ? Puree.password : password
    end

    # Get
    #
    # @param optional limit [Integer]
    # @param optional offset [Integer]
    # @param optional resource [Symbol]
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
      @endpoint = @endpoint.sub(/(\/)+$/, '')
      @auth = Base64::strict_encode64(@username + ':' + @password)

      @options = {
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

      metadata ? metadata : []
    end




    # All metadata
    #
    # @return [Array<Hash>]
    def metadata
      statistic
    end


    private

    # Statistic
    #
    # @return [Array<Hash>]
    def statistic
      path = '//downloadCount'
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
