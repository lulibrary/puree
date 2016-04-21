module Puree
  class Resource

    def initialize (endpoint, username, password, resource_type)
      @resource_type = resource_type
      # strip any trailing slash
      @endpoint = endpoint.sub(/(\/)+$/,'')
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

    def response
      @response ? @response : nil
    end

    def content
      if @response
        response_name = service_response_name
        if data?
          @response.parsed_response[response_name]['result']['content']
        else
          nil
        end
      else
        nil
      end
    end

    def node(name)
      if @response
        response_name = service_response_name
        if data?
          @response.parsed_response[response_name]['result']['content'][name]
        else
          nil
        end
      else
        nil
      end
    end

    def data?
      response_name = service_response_name
      @response.parsed_response[response_name]['count'] === '1' ? true : false
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