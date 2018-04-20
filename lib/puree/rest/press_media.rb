module Puree

  module REST

    # Requests for the Press Media resource
    #
    class PressMedia < Puree::REST::Base

      private

      def collection
        'press-media'
      end

    end

  end

end
