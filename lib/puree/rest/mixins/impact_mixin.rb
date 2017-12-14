module Puree
    module REST
      module ImpactMixin

      # (see Puree::REST::Base#find)
      def impacts(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'impacts',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
