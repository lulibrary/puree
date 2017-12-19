module Puree

  module REST

    # Requests for the Application resource
    #
    class Application < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
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
