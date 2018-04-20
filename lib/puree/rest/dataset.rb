module Puree

  module REST

    # Requests for the Dataset resource
    #
    class Dataset < Puree::REST::Base

      private

      def collection
        'datasets'
      end

    end

  end

end
