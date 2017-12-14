module Puree
  module REST
    module ActivityMixin

      # (see Puree::REST::Base#find)
      def activities(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'activities',
                                        params: params,
                                        accept: accept)
      end
    end
  end
end
