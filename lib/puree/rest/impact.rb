module Puree

  module REST

    # Requests for the Impact resource
    #
    class Impact < Puree::REST::Base

      private

      def collection
        'impacts'
      end

    end

  end

end
