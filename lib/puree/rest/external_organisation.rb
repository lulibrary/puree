module Puree

  module REST

    # Requests for the External Organisation resource
    #
    class ExternalOrganisation < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'external-organisations'
      end

    end

  end

end
