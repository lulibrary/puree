module Puree

  module XMLExtractor

    # Associated extractor mixin.
    #
    module AssociatedMixin

      # Combines projects and publications
      # @return [Array<Puree::Model::RelatedContentHeader>]
      def associated
        xpath_result = xpath_query '/associatedContent/relatedContent'
        data_arr = []
        xpath_result.each { |i|
          related = Puree::Model::RelatedContentHeader.new
          related.type = i.xpath('typeClassification').text.strip
          related.title = i.xpath('title').text.strip
          related.uuid = i.attr('uuid').strip
          data_arr << related
        }
        data_arr.uniq { |d| d.uuid }
      end

    end

  end
end
