module Puree

  module XMLExtractor

    # Identifier mixin.
    #
    module IdentifierMixin

      # @return [Array<Model::Identifier>]
      def identifiers
        xpath_result = xpath_query '/ids/id'
        data = []
        xpath_result.each do |d|
          identifier = Puree::Model::Identifier.new
          identifier.id = d.xpath('value').text.strip
          identifier.type = d.xpath('type/term/text').text.strip
          data << identifier
        end
        data.uniq { |d| d.id }
      end

    end

  end
end
