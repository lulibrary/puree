module Puree
  module API
    module FormerMixin

      # (see Puree::API::Base#all)
      def former(params: {}, accept: :xml)
        get_request_collection_subcollection(subcollection: 'former',
                                         params: params,
                                         accept: accept)
      end

    end
  end
end
