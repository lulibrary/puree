module Puree

  module Extractor

    # Person extractor.
    #
    class Person < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup :person
      end

      # Find a person by identifier.
      #
      # @param uuid [String]
      # @param id [String]
      # @param employee_id [String]
      # @return [Puree::Model::Person]
      def find_by_id(uuid: nil, id: nil, employee_id: nil)
        raise 'Cannot perform a request without a configuration' if @config.nil?
        @response = @request.get uuid:           uuid,
                                 id:             id,
                                 employee_id:    employee_id,
                                 latest_api:     @latest_api,
                                 resource_type:  @resource_type
        set_content @response.body
      end

      private

      def combine_metadata
        super
        @model.affiliations = @extractor.affiliations
        @model.email_addresses = @extractor.email_addresses
        @model.employee_id = @extractor.employee_id
        @model.hesa_id = @extractor.hesa_id
        @model.image_urls = @extractor.image_urls
        @model.keywords = @extractor.keywords
        @model.name = @extractor.name
        @model.orcid = @extractor.orcid
        @model.scopus_id = @extractor.scopus_id
        @model
      end

      # Configure a Pure host for API access.
      #
      # @param config [Hash]
      # @option config [String] :url The URL of the Pure host.
      # @option config [String] :username The username of the Pure host account.
      # @option config [String] :password The password of the Pure host account.
      def configure_api(config)
        @config = Puree::API::Configuration.new url: config[:url]
        @config.basic_auth username: config[:username],
                           password: config[:password]

        @request = Puree::API::PersonRequest.new url: @config.url
        if @config.basic_auth?
          @request.basic_auth username: @config.username,
                              password: @config.password
        end
      end

    end

  end

end
