module Puree
  module Model
    class Address

      # @return [String, nil]
      attr_accessor :street

      # @return [String, nil]
      attr_accessor :building

      # @return [String, nil]
      attr_accessor :postcode

      # @return [String, nil]
      attr_accessor :city

      # @return [String, nil]
      attr_accessor :country

      def initialize
        @street = nil
        @building = nil
        @postcode = nil
        @city = nil
        @country = nil
      end

    end
  end
end