module Puree
  module Model
    class Resource

      # @return [String, nil]
      attr_reader :uuid

      # @return [Time, nil]
      attr_reader :created

      # @return [Time, nil]
      attr_reader :modified

      # @return [String, nil]
      attr_reader :locale

      # @param [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param [Time]
      def created=(v)
        @created = v
      end

      # @param [Time]
      def modified=(v)
        @modified = v
      end

      # @param [String]
      def locale=(v)
        @locale = v if v && !v.empty?
      end

    end
  end
end