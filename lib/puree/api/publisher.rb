module Puree

  module API

    # Requests for the Publisher resource
    #
    class Publisher < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      # (see Puree::API::Base#all)
      def approved(params: {}, accept: :xml)
        get_request_collection_subcollection(subcollection: 'approved',
                                         params: params,
                                         accept: accept)
      end

      private

      def collection
        'publishers'
      end

    end

  end

end
