module Puree
  module Model
    class TemporalRange < Puree::Model::Structure

        # @return [Time, nil]
        attr_accessor :start

        # @return [Time, nil]
        attr_accessor :end

    end
  end
end