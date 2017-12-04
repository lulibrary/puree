require 'sax-machine'

module Puree
  module ModelFoo
    class OrganisationHeader
      include SAXMachine

      # @return [String, nil]
      element :uuid

      # @return [String, nil]
      element :name

      # @return [String, nil]
      element :type
    end
  end
end
