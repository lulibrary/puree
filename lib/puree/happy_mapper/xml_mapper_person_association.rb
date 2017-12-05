module Purifier
  class PersonAssociation
    include HappyMapper

    tag 'personAssociation'

    # @return [Purifier::PersonHeader]
    has_one :person, Purifier::PersonHeader

    # @return [String]
    has_one :role, String, tag: 'personRole'
  end
end