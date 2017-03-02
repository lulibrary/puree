module Puree
  module Model

    # A minimal representation of an Event
    #
    class EventHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :title

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [String]
      def title=(v)
        @title = v if v && !v.empty?
      end

    end
  end
end