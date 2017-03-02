module Puree
  module Model

    # One or two dates which are part of a date range
    class TemporalRange < Puree::Model::Structure

        # @return [Time, nil]
        attr_accessor :start

        # @return [Time, nil]
        attr_accessor :end

    end
  end
end