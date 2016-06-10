module Puree

  # Collection resource
  #
  class Collection < Resource

    # @param api [Symbol]
    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(api: nil,
                   endpoint: nil,
                   username: nil,
                   password: nil)
      super(api: api,
            endpoint: endpoint,
            username: username,
            password: password)
      @uuids = []
    end

    # Get
    #
    # @param optional limit [Integer]
    # @param optional offset [Integer]
    # @param optional created_start [String]
    # @param optional created_end [String]
    # @param optional modified_start [String]
    # @param optional modified_end [String]
    # @return [HTTParty::Response]
    def get(
            limit:            20,
            offset:           0,
            created_start:    nil,
            created_end:      nil,
            modified_start:   nil,
            modified_end:     nil)

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
          latest_api:       true,
          resource_type:    @resource_type.to_sym,
          rendering:        :system,
          limit:            limit,
          offset:           offset,
          created_start:    created_start,
          created_end:      created_end,
          modified_start:   modified_start,
          modified_end:     modified_end
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

      if @options[:created_start]
        query['createdDate.fromDate'] = @options[:created_start]
      end

      if @options[:created_end]
        query['createdDate.toDate'] = @options[:created_end]
      end

      if @options[:modified_start]
        query['modifiedDate.fromDate'] = @options[:modified_start]
      end

      if @options[:modified_end]
        query['modifiedDate.toDate'] = @options[:modified_end]
      end

      @response = HTTParty.get(build_url, query: query, headers: headers)
    end


    # Array of UUIDs
    #
    # @return [Array<String>]
    def uuid
      collect_uuid
      @uuids
    end



    private


    def collect_uuid
      path = '//renderedItem/@renderedContentUUID'
      xpath_result = xpath_query path
      xpath_result.each { |i| @uuids << i.text.strip }
    end

    alias :find :get

  end

end