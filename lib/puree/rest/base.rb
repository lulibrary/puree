require 'http'

module Puree

  module REST

    # Requests for a resource
    #
    class Base

      # @param config [Hash]
      # @option config [String] :url URL of the Pure host
      # @option config [String] :username Username of the Pure host account
      # @option config [String] :password Password of the Pure host account
      # @option config [String] :api_key API key of the Pure host account
      def initialize(config)
        @http_client = HTTP::Client.new
        if config[:username] || config[:password]
          options = {}
          options[:user] = config[:username]
          options[:pass] = config[:password]
          @http_client = @http_client.basic_auth options
        end
        @http_client = @http_client.headers(api_key_header(config[:api_key]))
        @url = config[:url]
      end

      # @param params [Hash] Combined GET and POST parameters for all records
      # @param accept [Symbol]
      # @return [HTTP::Response]
      def all_complex(params: {}, accept: :xml)
        post_request_collection params: params,
                                accept: accept
      end

      # @param params [Hash] GET parameters for all records
      # @param accept [Symbol]
      # @return [HTTP::Response]
      def all(params: {}, accept: :xml)
        get_request_collection params: params,
                               accept: accept
      end

      # @param id [String]
      # @param params [Hash]
      # @param accept [Symbol]
      # @return [HTTP::Response]
      def find(id:, params: {}, accept: :xml)
        get_request_singleton id: id,
                          params: params,
                          accept: accept
      end

      # @param accept [Symbol]
      # @return (see Puree::REST::Base#all)
      def orderings(accept: :xml)
        get_request_meta meta_type: 'orderings',
                     accept: accept
      end

      # @param accept [Symbol]
      # @return (see Puree::REST::Base#all)
      def renderings(accept: :xml)
        get_request_meta meta_type: 'renderings',
                     accept: accept
      end

      private

      def accept_header(accept)
        case accept
          when :json
            return { 'Accept' => 'application/json' }
          when :xml
            return { 'Accept' => 'application/xml' }
        end
      end

      def content_type_header(content_type)
        case content_type
        when :json
          return { 'Content-Type' => 'application/json' }
        when :xml
          return { 'Content-Type' => 'application/xml' }
        end
      end

      def api_key_header(key)
        msg = 'API key incomplete in configuration'
        raise msg if !key
        { 'api-key' => key }
      end

      def url_collection
        File.join @url, collection
      end

      def url_collection_subcollection(subcollection)
        File.join url_collection, subcollection
      end

      def url_singleton(id)
        File.join url_collection, id
      end

      def url_singleton_subcollection(id, subcollection)
        File.join url_singleton(id), subcollection
      end

      def meta(type)
        File.join "#{url_collection}-meta", type
      end

      # @return (see Puree::REST::Base#all_complex)
      def post_request_collection(params: {}, accept: :xml)
        @http_client = @http_client.headers(accept_header(accept))
        @http_client = @http_client.headers(content_type_header(:json))
        @http_client.post url_collection, json: params
      end

      # @return (see Puree::REST::Base#all)
      def get_request_collection(params: {}, accept: :xml)
        @http_client = @http_client.headers(accept_header(accept))
        @http_client.get url_collection, params: params
      end

      # @return (see Puree::REST::Base#all)
      def get_request_collection_subcollection(subcollection:, params: {}, accept: :xml)
        @http_client = @http_client.headers(accept_header(accept))
        @http_client.get meta(url_collection_subcollection(subcollection)), params: params
      end

      # @return (see Puree::REST::Base#all)
      def get_request_singleton(id:, params: {}, accept: :xml)
        @http_client = @http_client.headers(accept_header(accept))
        @http_client.get url_singleton(id), params: params
      end

      # @return (see Puree::REST::Base#all)
      def get_request_singleton_subcollection(id:, subcollection:, params: {}, accept: :xml)
        @http_client = @http_client.headers(accept_header(accept))
        @http_client.get url_singleton_subcollection(id, subcollection), params: params
      end

      # @return (see Puree::REST::Base#all)
      def get_request_meta(meta_type:, accept: :xml)
        @http_client = @http_client.headers(accept_header(accept))
        @http_client.get meta(meta_type)
      end

    end

  end

end