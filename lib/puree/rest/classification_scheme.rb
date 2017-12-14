module Puree

  module REST

    # Requests for the Classification Scheme resource
    #
    class ClassificationScheme < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'classification-schemes'
      end

    end

  end

end
