module Puree
  module API
    module DatasetMixin

        # (see Puree::API::Base#find)
        def datasets(id:, params: {}, accept: :xml)
          get_request_singleton_subcollection(id: id,
                                          subcollection: 'datasets',
                                          params: params,
                                          accept: accept)
        end

    end
  end
end
