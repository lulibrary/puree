module Puree
  module Mapper
    class Resource
      include HappyMapper

      # @return [String]
      attribute :uuid, String

      # @return [Time]
      has_one :createdAt, Time, xpath: 'info/createdDate'

      # @return [Time]
      has_one :createdBy, Time, xpath: 'info/createdBy'

      # @return [Time]
      has_one :modifiedAt, Time, xpath: 'info/modifiedDate'

      # @return [Time]
      has_one :modifiedBy, Time, xpath: 'info/modifiedBy'
    end
  end
end
