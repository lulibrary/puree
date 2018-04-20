require 'puree/rest/mixins/active_mixin'

module Puree

  module REST

    # Requests for the Project resource
    #
    class Project < Puree::REST::Base
      include Puree::REST::ActiveMixin

      private

      def collection
        'projects'
      end

    end

  end

end
