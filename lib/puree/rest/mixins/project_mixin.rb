module Puree
  module REST
    module ProjectMixin

      # (see Puree::REST::Base#find)
      def projects(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'projects',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
