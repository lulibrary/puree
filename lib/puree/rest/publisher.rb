module Puree

  module REST

    # Requests for the Publisher resource
    #
    class Publisher < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      # (see Puree::REST::Base#all)
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
