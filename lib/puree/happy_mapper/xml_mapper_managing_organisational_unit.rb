require 'happymapper'

module Puree
  module Mapper
    class ManagingOrganisationalUnitHeader
      include HappyMapper

      tag 'managingOrganisationalUnit'

      # @return [String, nil]
      attribute :uuid, String

      # @return [String, nil]
      element :name, String

      # @return [String, nil]
      element :type, String

    end
  end
end
