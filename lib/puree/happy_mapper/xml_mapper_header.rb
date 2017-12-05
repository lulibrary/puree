module Purifier
  class Header
    include HappyMapper

    # @return [String]
    attribute :uuid, String

    # @return [String]
    has_one :name, String

    # @return [String]
    has_one :type, String
  end
end