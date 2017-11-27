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
      attr_reader :created_date

      # @return [String, nil]
      attr_reader :modified_by

      # @return [Time, nil]
      attr_reader :modified_date

      # @return [String, nil]
      attr_reader :locale

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [String]
      def created_by=(v)
        @created_by = v
      end

      # @param v [Time]
      def created_date=(v)
        @created_date = v
      end

      # @param v [String]
      def modified_by=(v)
        @modified_by = v
      end

      # @param v [Time]
      def modified_date=(v)
        @modified_date = v
      end

      # @param v [String]
      def locale=(v)
        @locale = v if v && !v.empty?
      end

    end
  end
end