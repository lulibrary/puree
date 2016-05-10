module Puree

  # Abstract base class for resources.
  #
  class Resource

    def initialize(resource_type)
      @resource_type = resource_type
      @api_map = Puree::Map.new.get
    end

    # Get
    #
    # @param endpoint [String]
    # @param username [String]
    # @param password [String]
    # @param uuid [String]
    # @param id [String]
    # @return [HTTParty::Response]
    def get(endpoint:nil, username:nil, password:nil, uuid:nil, id:nil)
      # strip any trailing slash
      @endpoint = endpoint.sub(/(\/)+$/, '')
      @auth = Base64::strict_encode64(username + ':' + password)

      @options = {
          latest_api: true,
          resource_type: @resource_type.to_sym,
          rendering: :xml_long,
          uuid: uuid,
          id: id,
      }
      headers = {
          'Accept' => 'application/xml',
          'Authorization' => 'Basic ' + @auth
      }
      query = {}
      query['rendering'] = @options[:rendering]
      if @options[:uuid]
        query['uuids.uuid'] = @options[:uuid]
      else
        if @options[:id]
          query['pureInternalIds.id'] = @options[:id]
        end
      end

      @response = HTTParty.get(url, query: query, headers: headers)

      if get_data?
        response_name = service_response_name
        content = @response.parsed_response[response_name]['result']['content']
        set_content(content)
      end
      @response
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



    private



    # Node
    #
    # @return [Hash]
    def node(*path)
      @content ? @content.dig(*path) : {}
    end


    # Is there any data after get?
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

    def url
      service = service_name
      if @options[:latest_api] === false
        service_api_mode = service
      else
        service_api_mode = service + '.current'
      end
      @endpoint + '/' + service_api_mode
    end

    def xpath_doc
      xml = @response.body
      doc = Nokogiri::XML xml
      doc.remove_namespaces!
    end

  end
end