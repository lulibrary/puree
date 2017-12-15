module Puree

  module REST

    # Requests for the Journal resource
    #
    class Journal < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
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
