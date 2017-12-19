module Puree
  module REST
    module ResearchOutputMixin

      # (see Puree::REST::Base#find)
      def research_outputs(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'research-outputs',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
