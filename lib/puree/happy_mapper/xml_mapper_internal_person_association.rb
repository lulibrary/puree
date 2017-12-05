module Purifier
  class InternalPersonAssociation
    include HappyMapper

    tag 'personAssociation'

    # @return [String]
    has_one :role, String, tag: 'personRole'

    # @return [String]
    has_one :uuid, String, xpath: 'person/@uuid'

    # # @return [String]
    # has_one :name, String, xpath: 'person/name'

  end
end