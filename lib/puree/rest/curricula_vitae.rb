module Puree

  module REST

    # Requests for the Curricula Vitae resource
    #
    class CurriculaVitae < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
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
