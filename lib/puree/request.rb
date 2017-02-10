module Puree

  class Request

    def initialize
      @api_map = Puree::Map.new
    end

    def get(uuid:,
            id:,
            rendering:,
            basic_auth:,
            latest_api:,
            resource_type:,
            base_url:,
            username:,
            password:)
          @basic_auth =     basic_auth
          @latest_api =    latest_api
          @resource_type =  resource_type
          @rendering =      rendering
          @uuid =           uuid
          @id =             id
          @base_url =       base_url
          @username =      username
          @password =      password

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
      if @basic_auth === true
        @auth = Base64::strict_encode64(@username + ':' + @password)
        headers['Authorization'] = 'Basic ' + @auth
      end
      url = build_url
      begin
        req = HTTP.headers accept: headers['Accept']
        if @basic_auth
          req = req.auth headers['Authorization']
      end
      rescue HTTP::Error => e
        puts 'HTTP::Error '+ e.message
      end
      req.get(url, params: params)
    end

    def params
      query = {}
      query['rendering'] = @rendering
      if @uuid
        query['uuids.uuid'] = @uuid
      else
        if @id
          query['pureInternalIds.id'] = @id
        end
      end
      if @rendering
        query['rendering'] = @rendering
      end
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

    def missing_credentials
      missing = []
      if @base_url.nil?
        missing << 'base_url'
      end

      if @basic_auth === true
        if @username.nil?
          missing << 'username'
        end
        if @password.nil?
          missing << 'password'
        end
      end

      missing
    end

  end

end