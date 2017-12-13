module Puree

  module API

    # Requests for the Prize resource
    #
    class Prize < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
