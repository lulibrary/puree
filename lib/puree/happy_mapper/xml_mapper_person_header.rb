module Purifier
  class PersonHeader
    include HappyMapper

    tag 'person'

    # @return [String]
    attribute :uuid, String

    # @return [String]
    has_one :name, String, xpath: '.'
  end
end