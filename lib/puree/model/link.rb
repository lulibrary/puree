module Puree
  module Model
    class Link < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :description

      # @return [String, nil]
      attr_reader :url

      # @param [String]
      def description=(v)
        @description = v if v && !v.empty?
      end

      # @param [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

    end
  end
end