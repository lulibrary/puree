module Puree
  module Model
    class Address < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :street

      # @return [String, nil]
      attr_reader :building

      # @return [String, nil]
      attr_reader :postcode

      # @return [String, nil]
      attr_reader :city

      # @return [String, nil]
      attr_reader :country

      # @param [String]
      def street=(v)
        @street = v if v && !v.empty?
      end

      # @param [String]
      def building=(v)
        @building = v if v && !v.empty?
      end

      # @param [String]
      def postcode=(v)
        @postcode = v if v && !v.empty?
      end

      # @param [String]
      def city=(v)
        @city = v if v && !v.empty?
      end

      # @param [String]
      def country=(v)
        @country = v if v && !v.empty?
      end

    end
  end
end