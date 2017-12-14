module Puree

  module REST

    # Requests for the External Person resource
    #
    class ExternalPerson < Puree::REST::Base

      # @option (see Puree::REST::Base#initialize)
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
