module Puree
  module Model
    class SpatialPoint < Struct.new(
        :latitude,
        :longitude
    )
    end
  end
end