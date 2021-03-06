module Puree
  module REST
    module PersonMixin

      # (see Puree::REST::Base#find)
      def persons(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'persons',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
