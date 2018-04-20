module Puree

  module REST

    # Requests for the Research Output resource
    #
    class ResearchOutput < Puree::REST::Base

      private

      def collection
        'research-outputs'
      end

    end

  end

end
