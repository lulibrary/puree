module Puree

  module API

    # Requests for the Research Output resource
    #
    class ResearchOutput < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'research-outputs'
      end

    end

  end

end
