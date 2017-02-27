module Puree
  module Model
    class CopyrightLicense < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :url

      # @param [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

    end
  end
end