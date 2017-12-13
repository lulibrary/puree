module Puree

  module API

    # Requests for the Classification Scheme resource
    #
    class ClassificationScheme < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
