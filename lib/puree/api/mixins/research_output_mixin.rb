module Puree
  module API
    module ResearchOutputMixin

      # (see Puree::API::Base#find)
      def research_outputs(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'research-outputs',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
