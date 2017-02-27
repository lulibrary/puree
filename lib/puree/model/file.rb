module Puree
  module Model
    class File < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :mime

      # @return [Fixnum, nil]
      attr_accessor :size

      # @return [String, nil]
      attr_reader :url

      # @return [Puree::Model::CopyrightLicense, nil]
      attr_reader :license

      # @param [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param [String]
      def mime=(v)
        @mime = v if v && !v.empty?
      end

      # @param [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

      # @param [Puree::Model::CopyrightLicense]
      def license=(v)
        @license = v if v && v.data?
      end

    end
  end
end