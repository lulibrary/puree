require 'puree/api/mixins/active_mixin'
module Puree

  module API

    # Requests for the Project resource
    #
    class Project < Puree::API::Base
      include Puree::API::ActiveMixin

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'projects'
      end

    end

  end

end
