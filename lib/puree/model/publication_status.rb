module Puree
  module Model
    class PublicationStatus < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :stage

      # @return [Time, nil]
      attr_accessor :date

      # @param [String]
      def stage=(v)
        @stage = v if v && !v.empty?
      end

    end
  end
end