module Puree
  module API
    module ActiveMixin

      # (see Puree::API::Base#all)
      def active(params: {}, accept: :xml)
        get_request_collection_subcollection(subcollection: 'active',
                                         params: params,
                                         accept: accept)
      end

    end
  end
end
