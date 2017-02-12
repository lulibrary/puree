module Puree

  class Request

    def initialize(base_url: nil)
      versatile_url_config base_url
      @api_map = Puree::Map.new
      @headers = {}
    end

    def basic_auth(username:, password:)
      versatile_basic_auth_config username, password
      auth = Base64::strict_encode64(@username + ':' + @password)
      @headers['Authorization'] = 'Basic ' + auth
    end

    def get(uuid: nil,
            id: nil,
            rendering: :xml_long,
            latest_api: true,
            resource_type:,
            limit: 20,
            offset: 0,
            content_type: nil)
          @latest_api =    latest_api
          @resource_type =  resource_type.to_sym
          @rendering =      rendering
          @uuid =           uuid
          @id =             id
          @limit = limit
          @offset = offset
          @content_type = content_type

      # strip any trailing slash
      @base_url = @base_url.sub(/(\/)+$/, '')
      @headers['Accept'] = 'application/xml'
      @req = HTTP.headers accept: @headers['Accept']
      if @headers['Authorization']
        @req = @req.auth @headers['Authorization']
      end
      @req.get(build_url, params: params)
    end

    def params
      query = {}
      if @uuid
        query['uuids.uuid'] = @uuid
      else
        if @id
          query['pureInternalIds.id'] = @id
        end
      end
      query['rendering'] = @rendering
      query['window.size'] = @limit
      query['offset'] = @offset
      query['contentType'] = @content_type
      query
    end

    def build_url
      service = @api_map.service_name(@resource_type)
      if @latest_api === false
        service_api_mode = service
      else
        service_api_mode = service + '.current'
      end
      @base_url + '/' + service_api_mode
    end

    private

    def versatile_url_config(base_url)
      @base_url = base_url.nil? ? Puree.base_url : base_url
    end

    def versatile_basic_auth_config(username, password)
      @username = username.nil? ? Puree.username : username
      @password = password.nil? ? Puree.password : password
    end

  end

end