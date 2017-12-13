module Puree
  module Model

    # A geographical point.
    #
    class SpatialPoint < Puree::Model::Structure

      # @return [Float, nil]
      attr_accessor :latitude

      # @return [Float, nil]
      attr_accessor :longitude

    end
  end
end