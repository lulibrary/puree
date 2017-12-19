module Puree

  module REST

    # Requests for the Press Media resource
    #
    class PressMedia < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'press-media'
      end

    end

  end

end
