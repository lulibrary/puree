module Puree
  module Mapper
    class Header
      include HappyMapper

      # @return [String, nil]
      attribute :uuid, String

      # @return [String, nil]
      has_one :name, String

      # @return [String, nil]
      has_one :type, String
    end
  end
end