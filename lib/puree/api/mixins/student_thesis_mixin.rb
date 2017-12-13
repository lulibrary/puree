module Puree
  module API
    module StudentThesisMixin

      # (see Puree::API::Base#find)
      def student_theses(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'student-theses',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
