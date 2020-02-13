module Puree

  module XMLExtractor

    # Research output extractor mixin.
    #
    module ResearchOutputMixin

      # Related research outputs
      # @return [Array<Puree::Model::RelatedContentHeader>]
      def research_outputs
        xpath_result = xpath_query '/relatedResearchOutputs/relatedResearchOutput'
        data_arr = []
        xpath_result.each { |i|
          related = Puree::Model::RelatedContentHeader.new
          related.uuid = i.attr('uuid').strip
          xpath_result_name = i.xpath('name/text')
          related.title = xpath_result_name.first.text.strip unless xpath_result_name.empty?
          xpath_result_type = i.xpath('type/term/text')
          related.type = xpath_result_type.first.text.strip unless xpath_result_type.empty?
          data_arr << related
        }
        data_arr.uniq { |d| d.uuid }
      end

    end

  end
end
