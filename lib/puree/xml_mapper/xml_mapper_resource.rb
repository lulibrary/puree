require 'sax-machine'

module Puree
  module ModelFoo
    module System
      include SAXMachine

      element :info, class: Puree::ModelFoo::Info

      # @return [Time, nil]
      # element :createdDate, as: :createdAt
        # Time.parse xpath_query_for_single_value('/info/createdDate')

      # # @return [String, nil]
      # def modified_by
      #   xpath_query_for_single_value('/info/modifiedBy')
      # end
      #
      # # @return [Time, nil]
      # def modified_at
      #   Time.parse xpath_query_for_single_value('/info/modifiedDate')
      # end
      #
      # # @return [String, nil]
      # def uuid
      #   xpath_query_for_single_value '/@uuid'
      # end
    end
  end
end
