module Puree

  module REST

    # Requests for the Activity resource
    #
    class Activity < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'activities'
      end

    end

  end

end
