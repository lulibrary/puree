module Puree

  # Abstract base class for resources.
  #
  class Resource

    def initialize(endpoint, username, password, resource_type)
      @resource_type = resource_type
      # strip any trailing slash
      @endpoint = endpoint.sub(/(\/)+$/, '')
      @auth = Base64::strict_encode64(username + ':' + password)
      @api_map = {
          resource_type: {
              dataset: {
                  service: 'datasets',
                  response: 'GetDataSetsResponse'
              },
              publication: {
                  service: 'publication',
                  response: 'GetPublicationResponse'
              }
          }
      }
    end

    # Get
    #
    # @return [HTTParty::Response]
    def get(uuid: nil, id: nil)
      @options = {
          latest_api: true,
          resource_type: @resource_type.to_sym,
          rendering: :xml_long,
          uuid: uuid,
          id: id
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
    end

    # Response, if get method has been called
    #
    # @return [HTTParty::Response]l
    # @return [Nil]
    def response
      @response ? @response : nil
    end



    private

    # Content
    #
    # @return [Hash]
    def content
      if @response
        response_name = service_response_name
        if data?
          @response.parsed_response[response_name]['result']['content']
        else
          {}
        end
      else
        {}
      end
    end

    # Node
    #
    # @return [Hash]
    def node(name)
      if @response
        response_name = service_response_name
        if data?
          @response.parsed_response[response_name]['result']['content'][name]
        else
          {}
        end
      else
        {}
      end
    end

    # Is there any data?
    #
    # @return [Boolean]
    def data?
      response_name = service_response_name
      @response.parsed_response[response_name]['count'] === '1' ? true : false
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

  end
end