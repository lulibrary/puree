module Puree
  module Model

    # Description of a file.
    #
    class File < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :mime

      # @return [Integer, nil]
      attr_accessor :size

      # @return [String, nil]
      attr_reader :url

      # @return [Puree::Model::CopyrightLicense, nil]
      attr_reader :license

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param v [String]
      def mime=(v)
        @mime = v if v && !v.empty?
      end

      # @param v [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

      # @param v [Puree::Model::CopyrightLicense]
      def license=(v)
        @license = v if v && v.data?
      end

    end
  end
end