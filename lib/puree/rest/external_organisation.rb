module Puree

  module REST

    # Requests for the External Organisation resource
    #
    class ExternalOrganisation < Puree::REST::Base

      private

      def collection
        'external-organisations'
      end

    end

  end

end
