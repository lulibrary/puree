module Puree

  module API

    # Requests for the Journal resource
    #
    class Journal < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'journals'
      end

    end

  end

end
