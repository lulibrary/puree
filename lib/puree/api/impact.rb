module Puree

  module API

    # Requests for the Impact resource
    #
    class Impact < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'impacts'
      end

    end

  end

end
