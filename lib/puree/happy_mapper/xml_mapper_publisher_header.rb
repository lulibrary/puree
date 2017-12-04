module Puree
  module Mapper
    class PublisherHeader < Puree::Mapper::Header
      include HappyMapper

      tag 'publisher'
    end
  end
end
