module Puree

  module REST

    # Requests for the Equipment resource
    #
    class Equipment < Puree::REST::Base

      private

      def collection
        'equipments'
      end

    end

  end

end
