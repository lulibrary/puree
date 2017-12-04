module Puree
  module Mapper
    class OrganisationalUnitHeader < Puree::Mapper::Header
      include HappyMapper

      tag 'organisationalUnit'
    end
  end
end
