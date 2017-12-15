module Puree

  module REST

    # Requests for the Equipment resource
    #
    class Equipment < Puree::REST::Base

      # (see Puree::REST::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'equipments'
      end

    end

  end

end
