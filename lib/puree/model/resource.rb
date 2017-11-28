module Puree
  module Model

    # A resource.
    #
    class Resource

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :created_by

      # @return [Time, nil]
      attr_reader :created_at

      # @return [String, nil]
      attr_reader :modified_by

      # @return [Time, nil]
      attr_reader :modified_at

      # @return [String, nil]
      # attr_reader :locale

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [String]
      def created_by=(v)
        @created_by = v
      end

      # @param v [Time]
      def created_at=(v)
        @created_at = v
      end

      # @param v [String]
      def modified_by=(v)
        @modified_by = v
      end

      # @param v [Time]
      def modified_at=(v)
        @modified_at = v
      end

      # @param v [String]
      # def locale=(v)
      #   @locale = v if v && !v.empty?
      # end

    end
  end
end