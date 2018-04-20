module Puree

  module REST

    # Requests for the External Person resource
    #
    class ExternalPerson < Puree::REST::Base

      private

      def collection
        'external-persons'
      end

    end

  end

end
