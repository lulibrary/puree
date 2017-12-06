module Puree

  module XMLExtractor

    # Publication collection XML extractor.
    #
    module PublicationCollection

      # Get models from any multi-record Research Output XML response
      #
      # @param xml [String]
      # @return [Hash{Symbol => Array<Puree::Model::Publication class/subclass>}]
      def self.classify(xml:)
        path_from_root = File.join 'result', xpath_root
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        xpath_result = doc.xpath path_from_root
        outputs = {
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
                extractor = Puree::XMLExtractor::JournalArticle.new xml: research_output.to_s
                outputs[:journal_article] << extractor.model
              when 'Conference paper'
                extractor = Puree::XMLExtractor::ConferencePaper.new xml: research_output.to_s
                outputs[:conference_paper] << extractor.model
              when 'Doctoral Thesis'
                extractor = Puree::XMLExtractor::Thesis.new xml: research_output.to_s
                outputs[:thesis] << extractor.model
              when "Master's Thesis"
                extractor = Puree::XMLExtractor::Thesis.new xml: research_output.to_s
                outputs[:thesis] << extractor.model
              else
                extractor = Puree::XMLExtractor::Publication.new xml: research_output.to_s
                outputs[:other] << extractor.model
            end
          end
        end
        outputs
      end

      private

      def self.xpath_root
        '/*'
      end

    end

  end

end