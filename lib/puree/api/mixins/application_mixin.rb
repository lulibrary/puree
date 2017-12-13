module Puree
  module API
      module ApplicationMixin

        # (see Puree::API::Base#find)
        def applications(id:, params: {}, accept: :xml)
          get_request_singleton_subcollection(id: id,
                                          subcollection: 'applications',
                                          params: params,
                                          accept: accept)
        end

      end
  end
end
