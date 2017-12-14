module Puree
  module REST
    module PrizeMixin

      # (see Puree::REST::Base#find)
      def prizes(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'prizes',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
