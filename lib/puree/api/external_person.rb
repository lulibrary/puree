module Puree

  module API

    # Requests for the External Person resource
    #
    class ExternalPerson < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'external-persons'
      end

    end

  end

end
