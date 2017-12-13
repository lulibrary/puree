module Puree

  module API

    # Requests for the Event resource
    #
    class Event < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
