module Puree

  module REST

    # Requests for the Prize resource
    #
    class Prize < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'prizes'
      end

    end

  end

end
