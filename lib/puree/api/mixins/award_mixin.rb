module Puree
  module API
    module AwardMixin

        # (see Puree::API::Base#find)
        def awards(id:, params: {}, accept: :xml)
          get_request_singleton_subcollection(id: id,
                                          subcollection: 'awards',
                                          params: params,
                                          accept: accept)
        end

    end
  end
end
