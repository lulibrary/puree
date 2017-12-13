module Puree

  module API

    # Requests for the Application resource
    #
    class Application < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'applications'
      end

    end

  end

end
