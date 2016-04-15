require 'puree/version'
require 'httparty'

module Puree

  class API

    def initialize(endpoint, username, password)
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

    def get(latest_api: true, resource_type: nil, rendering: :xml_long, uuid: nil, id: nil)
      @options = {
        latest_api: latest_api,
        resource_type: resource_type.to_sym,
        rendering: rendering.to_sym,
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
      @response ? @response : 'No response yet'
    end

    def content
      if @response
        response_name = service_response_name
        @response.parsed_response[response_name]['result']['content']
      else
        response
      end
    end

    def node(name)
      if @response
        response_name = service_response_name
        @response.parsed_response[response_name]['result']['content'][name]
      else
        response
      end
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