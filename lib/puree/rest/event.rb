module Puree

  module REST

    # Requests for the Event resource
    #
    class Event < Puree::REST::Base

      private

      def collection
        'events'
      end

    end

  end

end
