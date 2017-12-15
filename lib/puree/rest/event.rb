module Puree

  module REST

    # Requests for the Event resource
    #
    class Event < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'events'
      end

    end

  end

end
