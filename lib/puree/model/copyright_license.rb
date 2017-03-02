module Puree
  module Model

    # A copyright license
    #
    class CopyrightLicense < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :url

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param v [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

    end
  end
end