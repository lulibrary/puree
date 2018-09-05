module Puree

  module REST

    # Requests for the Application resource
    #
    class Application < Puree::REST::Base

      private

      def collection
        'applications'
      end

    end

  end

end
