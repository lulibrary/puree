require 'sax-machine'

module Puree
  module ModelFoo
    class Info
      include SAXMachine

      # @return [Time, nil]
      element :createdDate, as: :createdAt do |i|
        Time.parse i
      end
    end
  end
end
