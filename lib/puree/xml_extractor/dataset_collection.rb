module Puree

  module XMLExtractor

    # Dataset collection XML extractor.
    #
    module DatasetCollection

      # Get models from any multi-record dataset XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Dataset>]
      def self.models(xml:)
        path_from_root = File.join 'result', xpath_root
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        xpath_result = doc.xpath path_from_root
        data = []
        xpath_result.each do |resource|
          extractor = Puree::XMLExtractor::Dataset.new xml: resource.to_s
          data << extractor.model
        end
        data
      end

      private

      def self.xpath_root
        '/dataSet'
      end

    end

  end

end