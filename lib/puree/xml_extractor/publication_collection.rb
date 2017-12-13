module Puree

  module XMLExtractor

    # Publication collection XML extractor.
    #
    module PublicationCollection

      # Get models from any multi-record Research Output XML response
      #
      # @param xml [String]
      # @return [Hash{Symbol => Array<Puree::Model::Publication class/subclass>}]
      def self.classify(xml)
        path_from_root = File.join 'result', xpath_root
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        xpath_result = doc.xpath path_from_root
        data = {
          journal_article: [],
          conference_paper: [],
          thesis: [],
          other: []
        }
        xpath_result.each do |research_output|
          type = research_output.xpath('type').text.strip
          unless type.empty?
            case type
              when 'Journal article'
                extractor = Puree::XMLExtractor::JournalArticle.new research_output.to_s
                data[:journal_article] << extractor.model
              when 'Conference paper'
                extractor = Puree::XMLExtractor::ConferencePaper.new research_output.to_s
                data[:conference_paper] << extractor.model
              when 'Doctoral Thesis'
                extractor = Puree::XMLExtractor::Thesis.new research_output.to_s
                data[:thesis] << extractor.model
              when "Master's Thesis"
                extractor = Puree::XMLExtractor::Thesis.new research_output.to_s
                data[:thesis] << extractor.model
              else
                extractor = Puree::XMLExtractor::Publication.new research_output.to_s
                data[:other] << extractor.model
            end
          end
        end
        data
      end

      private

      def self.xpath_root
        '/*'
      end

    end

  end

end