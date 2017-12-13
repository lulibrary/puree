module Puree
  module API
    module PrizeMixin

      # (see Puree::API::Base#find)
      def prizes(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'prizes',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
