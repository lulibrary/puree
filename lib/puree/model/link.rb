module Puree
  module Model

    # URL which points to something of interest.
    #
    class Link < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :description

      # @return [String, nil]
      attr_reader :url

      # @param v [String]
      def description=(v)
        @description = v if v && !v.empty?
      end

      # @param v [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

    end
  end
end