module Puree

  module REST

    # Requests for the Prize resource
    #
    class Prize < Puree::REST::Base

      private

      def collection
        'prizes'
      end

    end

  end

end
