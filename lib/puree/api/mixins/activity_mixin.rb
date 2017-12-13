module Puree
  module API
    module ActivityMixin

      # (see Puree::API::Base#find)
      def activities(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'activities',
                                        params: params,
                                        accept: accept)
      end
    end
  end
end
