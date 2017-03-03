module Puree
  module Model

    # A minimal representation of a Download.
    #
    class DownloadHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [Fixnum, nil]
      attr_accessor :count

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

    end
  end
end