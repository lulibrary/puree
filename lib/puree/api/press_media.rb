module Puree

  module API

    # Requests for the Press Media resource
    #
    class PressMedia < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
