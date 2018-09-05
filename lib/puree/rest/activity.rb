module Puree

  module REST

    # Requests for the Activity resource
    #
    class Activity < Puree::REST::Base

      private

      def collection
        'activities'
      end

    end

  end

end
