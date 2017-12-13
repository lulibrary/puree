module Puree

  module API

    # Requests for the Equipment resource
    #
    class Equipment < Puree::API::Base

      # @option (see Puree::API::Base#initialize)
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
