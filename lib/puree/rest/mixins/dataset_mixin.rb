module Puree
  module REST
    module DatasetMixin

        # (see Puree::REST::Base#find)
        def datasets(id:, params: {}, accept: :xml)
          get_request_singleton_subcollection(id: id,
                                          subcollection: 'datasets',
                                          params: params,
                                          accept: accept)
        end

    end
  end
end
