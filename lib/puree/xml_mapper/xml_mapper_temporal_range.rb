require 'sax-machine'

module Puree
  module ModelFoo
    class TemporalRange
      include SAXMachine

      # @return [Puree::ModelFoo::Date, nil]
      element :startDate, as: :start, class: Puree::ModelFoo::Date

      # @return [Puree::ModelFoo::Date, nil]
      element :endDate, as: :end, class: Puree::ModelFoo::Date

    end
  end
end
