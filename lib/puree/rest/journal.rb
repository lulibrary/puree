module Puree

  module REST

    # Requests for the Journal resource
    #
    class Journal < Puree::REST::Base

      private

      def collection
        'journals'
      end

    end

  end

end
