module Puree

  module API

    # Handles requests to Pure.
    #
    class PersonRequest < Puree::API::Request

      def initialize(url:)
        super
      end

      # Perform a GET request to Pure
      #
      # @param uuid [String]
      # @param id [String]
      # @param employee_id [String]
      # @param rendering [String]
      # @param latest_api [Boolean]
      # @param resource_type [String]
      # @return [HTTP::Response]
      def get(uuid: nil,
              id: nil,
              employee_id: nil,
              rendering: :xml_long,
              latest_api: true,
              resource_type:)
            @latest_api =     latest_api
            @resource_type =  resource_type.to_sym
            @rendering =      rendering
            @uuid =           uuid
            @id =             id
            @employee_id =    employee_id

        # strip any trailing slash
        @url = @url.sub(/(\/)+$/, '')
        @headers['Accept'] = 'application/xml'
        @req = HTTP.headers accept: @headers['Accept']
        if @headers['Authorization']
          @req = @req.auth @headers['Authorization']
        end
        @req.get(build_url, params: parameters)
      end

      private

      def parameters
        query = {}
        if @uuid
          query['uuids.uuid'] = @uuid
        elsif @id
          query['pureInternalIds.id'] = @id
        elsif @employee_id
          query['personEmployeeIds.value'] = @employee_id
        end
        query['rendering'] = @rendering
        query
      end

    end

  end

end