module Puree

  module XMLExtractor

    # Project extractor mixin.
    #
    module ProjectMixin

      # Projects
      # @return [Array<Puree::Model::RelatedContentHeader>]
      def projects
        xpath_result = xpath_query '/relatedProjects/relatedProject'

        data_arr = []
        xpath_result.each { |i|
          related = Puree::Model::RelatedContentHeader.new
          related.type = i.xpath('types/type').first.text.strip
          related.title = i.xpath('names/name').first.text.strip
          related.uuid = i.attr('uuid').strip
          data_arr << related
        }
        data_arr.uniq { |d| d.uuid }
      end

    end

  end
end
