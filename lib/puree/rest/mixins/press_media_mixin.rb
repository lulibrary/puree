module Puree
  module REST
    module PressMediaMixin

      # (see Puree::REST::Base#find)
      def press_media(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                        subcollection: 'press-media',
                                        params: params,
                                        accept: accept)
      end

    end
  end
end
