module Puree

  module API

    # Requests for the Curricula Vitae resource
    #
    class CurriculaVitae < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'curricula-vitae'
      end

    end

  end

end
