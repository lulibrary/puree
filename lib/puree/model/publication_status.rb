module Puree
  module Model

    # Status of a publication.
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