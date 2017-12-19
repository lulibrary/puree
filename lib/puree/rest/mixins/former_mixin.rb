module Puree
  module REST
    module FormerMixin

      # (see Puree::REST::Base#all)
      def former(params: {}, accept: :xml)
        get_request_collection_subcollection(subcollection: 'former',
                                         params: params,
                                         accept: accept)
      end

    end
  end
end
