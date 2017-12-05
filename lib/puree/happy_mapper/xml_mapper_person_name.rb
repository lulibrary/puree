module Purifier
  class PersonName
    include HappyMapper

    tag 'name'

    # @return [String]
    has_one :first, String, tag: 'firstName'

    # @return [String]
    has_one :last, String, tag: 'lastName'
  end
end