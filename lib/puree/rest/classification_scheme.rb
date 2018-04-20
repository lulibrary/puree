module Puree

  module REST

    # Requests for the Classification Scheme resource
    #
    class ClassificationScheme < Puree::REST::Base

      private

      def collection
        'classification-schemes'
      end

    end

  end

end
