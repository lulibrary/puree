require 'happymapper'

module Puree
  module Mapper
    class Header
      include HappyMapper

      # @return [String, nil]
      attribute :uuid, String

      # @return [String, nil]
      element :name, String

      # @return [String, nil]
      element :type, String
    end
  end
end