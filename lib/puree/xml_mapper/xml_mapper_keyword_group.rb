require 'sax-machine'

module Puree
  module ModelFoo
    class UserDefinedKeywords
      include SAXMachine

      # @return [Array<String>, nil]
      elements :keyword, as: :keywords
    end
  end
end
