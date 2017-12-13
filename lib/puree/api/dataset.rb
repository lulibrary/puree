module Puree

  module API

    # Requests for the Dataset resource
    #
    class Dataset < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
