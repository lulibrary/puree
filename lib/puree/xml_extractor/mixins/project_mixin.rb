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
          related.uuid = i.attr('uuid').strip
          xpath_result_name = i.xpath('names/name')
          related.title = xpath_result_name.first.text.strip unless xpath_result_name.empty?
          xpath_result_type = i.xpath('types/type')
          related.type = xpath_result_type.first.text.strip unless xpath_result_type.empty?
          data_arr << related
        }
        data_arr.uniq { |d| d.uuid }
      end

    end

  end
end
