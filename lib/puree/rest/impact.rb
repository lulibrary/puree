module Puree

  module REST

    # Requests for the Impact resource
    #
    class Impact < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
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
