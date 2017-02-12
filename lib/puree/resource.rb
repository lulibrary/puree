module Puree

  # Abstract base class for resources.
  #
  class Resource

    attr_reader :response

    # @param base_url [String]
    # @param bleeding [Boolean]
    def initialize(base_url:, bleeding: true)
      @latest_api = bleeding
      @request = Puree::Request.new base_url: base_url
      @metadata = {}
    end

    def basic_auth(username:, password:)
      @request.basic_auth username: username,
                          password: password
    end

    # Get
    #
    # @param uuid [String]
    # @param id [String]
    # @return [Hash]
    def get(uuid: nil, id: nil, rendering: :xml_long)
      reset
      @response = @request.get uuid:           uuid,
                               id:             id,
                               rendering:      rendering,
                               latest_api:     @latest_api,
                               resource_type:  @resource_type
      set_content @response.body
    end

    # UUID
    #
    # @return [String]
    def uuid
      @metadata['uuid']
    end

    # Created (UTC datetime)
    #
    # @return [String]
    def created
      @metadata['created']
    end

    # Modified (UTC datetime)
    #
    # @return [String]
    def modified
      @metadata['modified']
    end

    # Locale (e.g. en-GB)
    #
    # @return [String]
    def locale
      @metadata['locale']
    end

    # Set content from XML. In order for metadata extraction to work, the XML must have
    # been retrieved using the .current version of the Pure API endpoints
    #
    # @param xml [String]
    def set_content(xml)
      if xml
        make_extractor
        @extractor.get_data? ? combine_metadata : {}
      end
    end

    private

    def make_extractor
      resource_class = "Puree::Extractor::#{@resource_type.to_s.capitalize}"
      @extractor = Object.const_get(resource_class).new xml: @response.body
    end

    # All metadata
    # @return [Hash]
    def combine_metadata
      o = {}
      o['uuid'] = @extractor.uuid
      o['created'] = @extractor.created
      o['modified'] = @extractor.modified
      o['locale'] = @extractor.locale
      o
    end

    def reset
      @response = nil
    end

    alias :find :get

  end
end