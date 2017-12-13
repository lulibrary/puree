module Puree

  module API

    # Requests for the Activity resource
    #
    class Activity < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
