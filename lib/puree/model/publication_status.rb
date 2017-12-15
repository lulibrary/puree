module Puree
  module Model

    # Publication status of a research output.
    #
    class PublicationStatus < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :stage

      # @return [Time, nil]
      attr_accessor :date

      # @param v [String]
      def stage=(v)
        @stage = v if v && !v.empty?
      end

    end
  end
end