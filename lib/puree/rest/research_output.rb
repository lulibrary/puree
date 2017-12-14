module Puree

  module REST

    # Requests for the Research Output resource
    #
    class ResearchOutput < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
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
