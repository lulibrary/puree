module Puree

  module API

    class Request

      def initialize(url:)
        @url = url
        @api_map = Puree::API::Map.new
        @headers = {}
      end

      def basic_auth(username:, password:)
        auth = Base64::strict_encode64("#{username}:#{password}")
        @headers['Authorization'] = 'Basic ' + auth
      end

      def get(uuid: nil,
              id: nil,
              rendering: :xml_long,
              latest_api: true,
              resource_type:,
              limit: 0,
              offset: 0,
              created_start: nil,
              created_end: nil,
              modified_start: nil,
              modified_end: nil,
              content_type: nil)
            @latest_api =    latest_api
            @resource_type =  resource_type.to_sym
            @rendering =      rendering
            @uuid =           uuid
            @id =             id
            @limit =          limit
            @offset =         offset
            @created_start =  created_start
            @created_end =    created_end
            @modified_start = modified_start
            @modified_end =   modified_end
            @content_type =   content_type

        # strip any trailing slash
        @url = @url.sub(/(\/)+$/, '')
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
        query['window.size'] = @limit if @limit > 0 unless @resource_type === :server # Server does not work if this is present
        query['window.offset'] = @offset if @limit > 0

        # Pure does allow blank value
        query['contentType'] = @content_type if @content_type

        # Pure does not allow blanks for these
        query['createdDate.toDate'] = @created_start if @created_start
        query['createdDate.fromDate'] = @created_end if @created_end
        query['modifiedDate.toDate'] = @modified_start if @modified_start
        query['modifiedDate.fromDate'] = @modified_end if @modified_end
        query
      end

      def build_url
        service = @api_map.service_name(@resource_type)
        if @latest_api === false
          service_api_mode = service
        else
          service_api_mode = service + '.current'
        end
        @url + '/' + service_api_mode
      end

    end

  end

end