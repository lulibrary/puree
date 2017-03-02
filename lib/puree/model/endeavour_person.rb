module Puree
  module Model

    # A person involved in an endeavour
    #
    class EndeavourPerson < Puree::Model::Structure

      # @return [String, Nil]
      attr_reader :uuid

      # @return [String, Nil]
      attr_reader :name

      # @return [String, Nil]
      attr_reader :role

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [Puree::Model::PersonName]
      def name=(v)
        @name = v if v && v.data?
      end

      # @param v [String]
      def role=(v)
        @role = v if v && !v.empty?
      end

    end
  end
end