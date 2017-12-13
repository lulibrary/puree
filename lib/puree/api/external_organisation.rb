module Puree

  module API

    # Requests for the External Organisation resource
    #
    class ExternalOrganisation < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
