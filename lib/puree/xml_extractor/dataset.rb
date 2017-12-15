module Puree

  module XMLExtractor

    # Dataset XML extractor.
    #
    class Dataset < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::DescriptionMixin
      include Puree::XMLExtractor::KeywordMixin
      include Puree::XMLExtractor::OrganisationalUnitMixin
      include Puree::XMLExtractor::OwnerMixin
      include Puree::XMLExtractor::PersonMixin
      include Puree::XMLExtractor::ResearchOutputMixin
      include Puree::XMLExtractor::WorkflowMixin
      include Puree::XMLExtractor::TitleMixin

      def initialize(xml)
        super
        setup_model :dataset
      end

      # Date made available
      # @return [Time, nil]
      def available
        Puree::Util::Date.hash_to_time temporal_date('publicationDate')
      end

      # Digital Object Identifier
      # @return [String, nil]
      def doi
        xpath_query_for_single_value '/doi'
      end

      # Supporting files
      # @return [Array<Puree::Model::File>]
      def files
        xpath_result = xpath_query '/documents/document'
        docs = []
        xpath_result.each do |d|
          doc = Puree::Model::File.new
          doc.name = d.xpath('title').text.strip
          # doc.mime = d.xpath('mimeType').text.strip
          # doc.size = d.xpath('size').text.strip.to_i
          doc.url = d.xpath('url').text.strip
          # doc['createdDate'] = d.xpath('createdDate').text.strip
          # doc['visibleOnPortalDate'] = d.xpath('visibleOnPortalDate').text.strip
          # doc['limitedVisibility'] = d.xpath('limitedVisibility').text.strip
          document_license = d.xpath('documentLicense')
          if !document_license.empty?
            license = Puree::Model::CopyrightLicense.new
            license.name = document_license.text.strip
            # license.name = document_license.xpath('term/localizedString').text.strip
            # license.url = document_license.xpath('description/localizedString').text.strip
            doc.license = license if license.data?
          end
          docs << doc
        end
        docs.uniq { |d| d.url }
      end

      # @return [Array<String>]
      def keywords
        keyword_group 'User-Defined Keywords'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_internal
        persons 'internal', '/personAssociations/personAssociation'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external', '/personAssociations/personAssociation'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other', '/personAssociations/personAssociation'
      end

      # Date of data production
      # @return [Puree::Model::TemporalRange, nil]
      def production
        temporal_range 'dataProductionPeriod/startDate', 'dataProductionPeriod/endDate'
      end

      # @return [Puree::Model::PublisherHeader, nil]
      def publisher
        xpath_result = xpath_query '/publisher'
        h = Puree::Model::PublisherHeader.new
        h.uuid = xpath_result.xpath('@uuid').text.strip
        h.name = xpath_result.xpath('name').text.strip
        h.type = xpath_result.xpath('type').text.strip
        h.data? ? h : nil
      end

      # @return [Array<String>]
      def spatial_places
        # Data from free-form text box
        xpath_result = xpath_query '/geographicalCoverage'
        data = []
        xpath_result.each do |i|
          data << i.text.strip
        end
        data.uniq
      end

      # Spatial coverage point
      # @return [Puree::Model::SpatialPoint, nil]
      def spatial_point
        xpath_result = xpath_query '/geoLocation/point'
        if !xpath_result.empty?
          point = Puree::Model::SpatialPoint.new
          arr = xpath_result.text.strip.split(',')
          point.latitude = arr[0].to_f
          point.longitude = arr[1].to_f
          point
        end
      end

      # Temporal coverage
      # @return [Puree::Model::TemporalRange, nil]
      def temporal
        temporal_range 'temporalCoveragePeriod/startDate', 'temporalCoveragePeriod/endDate'
      end

      private

      # Temporal range
      # @return [Puree::Model::TemporalRange, nil]
      def temporal_range(start_path, end_path)
        range_start = Puree::Util::Date.hash_to_time temporal_date(start_path)
        range_end = Puree::Util::Date.hash_to_time temporal_date(end_path)
        if range_start || range_end
          range = Puree::Model::TemporalRange.new
          range.start = range_start if range_start
          range.end = range_end if range_end
          return range
        end
        nil
      end

      # Temporal coverage date
      # @return [Hash]
      def temporal_date(date_path)
        path = "/#{date_path}"
        xpath_result = xpath_query path
        o = {}
        o['year'] = xpath_result.xpath('year').text.strip
        o['month'] = xpath_result.xpath('month').text.strip
        o['day'] = xpath_result.xpath('day').text.strip
        Puree::Util::Date.normalise o
      end

      def xpath_root
        '/dataSet'
      end

      def combine_metadata
        super
        @model.available = available
        @model.description = description
        @model.doi = doi
        @model.files = files
        @model.keywords = keywords
        @model.organisational_units = organisational_units
        @model.owner = owner
        @model.persons_internal = persons_internal
        @model.persons_external = persons_external
        @model.persons_other = persons_other
        @model.production = production
        @model.research_outputs = research_outputs
        @model.publisher = publisher
        @model.spatial_places = spatial_places
        @model.spatial_point = spatial_point
        @model.temporal = temporal
        @model.title = title
        @model.workflow = workflow
        @model
      end

    end

  end

end