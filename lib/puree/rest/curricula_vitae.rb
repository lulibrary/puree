module Puree

  module REST

    # Requests for the Curricula Vitae resource
    #
    class CurriculaVitae < Puree::REST::Base

      private

      def collection
        'curricula-vitae'
      end

    end

  end

end
