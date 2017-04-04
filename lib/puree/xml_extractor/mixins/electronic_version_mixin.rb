module Puree

  module XMLExtractor

    # Electronic version extractor mixin.
    #
    module ElectronicVersionMixin

      # @return [Array<String>, nil]
      def dois
        xpath_query_for_multi_value '/electronicVersionAssociations/electronicVersionDOIAssociations/electronicVersionDOIAssociation/doi'
      end

      # @return [Array<Puree::Model::File>]
      def files
        xpath_result = xpath_query '/electronicVersionAssociations/electronicVersionFileAssociations/electronicVersionFileAssociation'
        docs = []
        xpath_result.each do |d|
          model = Puree::Model::File.new
          model.name = d.xpath('file/fileName').text.strip
          model.mime = d.xpath('file/mimeType').text.strip
          model.size = d.xpath('file/size').text.strip.to_i
          model.url = d.xpath('file/url').text.strip
          document_license = d.xpath('licenseType')
          if !document_license.empty?
            license = Puree::Model::CopyrightLicense.new
            license.name = document_license.xpath('term/localizedString').text.strip
            license.url = document_license.xpath('description/localizedString').text.strip
            model.license = license if license.data?
          end
          docs << model
        end
        docs.uniq { |d| d.url }
      end

      # @return [Array<String>, nil]
      def links
        xpath_query_for_multi_value '/electronicVersionAssociations/electronicVersionLinkAssociations/electronicVersionLinkAssociation/link'
      end

    end

  end
end
