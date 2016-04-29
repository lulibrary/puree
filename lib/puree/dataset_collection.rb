module Puree

  # Dataset collection resource
  #
  class DatasetCollection < Resource

    def initialize
      super(:dataset)
      @uuids = []
    end

    # Get
    #
    # @param endpoint [String]
    # @param username [String]
    # @param password [String]
    # @param qty [Integer]
    # @return [HTTParty::Response]
    def get(endpoint:nil, username:nil, password:nil, qty:nil)
      # strip any trailing slash
      @endpoint = endpoint.sub(/(\/)+$/, '')
      @auth = Base64::strict_encode64(username + ':' + password)

      @options = {
          latest_api: true,
          resource_type: @resource_type.to_sym,
          rendering: :system,
          qty: qty
      }
      headers = {
          'Accept' => 'application/xml',
          'Authorization' => 'Basic ' + @auth
      }
      query = {}
      query['rendering'] = @options[:rendering]
      if @options[:qty]
        query['window.size'] = @options[:qty]
      end

      @response = HTTParty.get(url, query: query, headers: headers)
    end


    # UUID
    #
    # @return [Array<String>]
    def UUID
      collectUUID
      @uuids
    end



    private


    def collectUUID
      response_name = service_response_name
      resp = @response[response_name]['result']['renderedItem']
      arr = []
      if resp.is_a?(Array)
        arr = resp
      else
        arr << resp
      end
      arr.each do |a|
        uuid = a['div']['table']['tbody']['tr'][0]['td']
        @uuids << uuid
      end
    end


  end

end