module Puree

  module REST

    # Requests for the Dataset resource
    #
    class Dataset < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'datasets'
      end

    end

  end

end
