require 'sax-machine'

module Puree
  module ModelFoo
    class Date
      include SAXMachine

      # @return [String, nil]
      element :year

      # @return [String, nil]
      element :month

      # @return [String, nil]
      element :day
    end
  end
end
