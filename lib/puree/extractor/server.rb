module Puree

  module Extractor

    # Server extractor.
    #
    class Server

      attr_reader :response

      # @param url [String]
      def initialize(url:)
        @resource_type = :server
        @request = Puree::API::Request.new url: url
      end

      # Provide credentials if necessary.
      #
      # @param username [String]
      # @param password [String]
      def basic_auth(username:, password:)
        @request.basic_auth username: username,
                            password: password
      end

      # Get server information.
      #
      # @return [Puree::Model::Server, nil]
      def get
        @response = @request.get resource_type:  @resource_type
        set_content @response.body
      end

      private

      def combine_metadata
        model = Puree::Model::Server.new
        model.version = @extractor.version
        model
      end

      # Set content from XML. In order for metadata extraction to work, the XML must have
      # been retrieved using the .current version of the Pure API endpoints
      #
      # @param xml [String]
      # @return [Puree::Model::Server, nil]
      def set_content(xml)
        if xml
          make_extractor
          @extractor.get_data? ? combine_metadata : nil
        end
      end

      def make_extractor
        @extractor = Puree::XMLExtractor::Server.new xml: @response.body
      end

      alias :find :get

    end

  end

end

