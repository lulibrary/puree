module Puree

  module XMLExtractor

    # Dataset XML extractor.
    #
    class Dataset < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :dataset
      end

      # Open access permission
      # @return [String, nil]
      def access
        xpath_query_for_single_value '/openAccessPermission/term/localizedString'
      end

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

      # Date made available
      # @return [Time, nil]
      def available
        Puree::Util::Date.hash_to_time temporal_date('dateMadeAvailable')
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/descriptions/classificationDefinedField/value/localizedString'
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
          doc.name = d.xpath('fileName').text.strip
          doc.mime = d.xpath('mimeType').text.strip
          doc.size = d.xpath('size').text.strip.to_i
          doc.url = d.xpath('url').text.strip
          # doc['createdDate'] = d.xpath('createdDate').text.strip
          # doc['visibleOnPortalDate'] = d.xpath('visibleOnPortalDate').text.strip
          # doc['limitedVisibility'] = d.xpath('limitedVisibility').text.strip
          document_license = d.xpath('documentLicense')
          if !document_license.empty?
            license = Puree::Model::CopyrightLicense.new
            license.name = document_license.xpath('/term/localizedString').text.strip
            license.url = document_license.xpath('/description/localizedString').text.strip
            doc.license = license if license.data?
          end
          docs << doc
        end
        docs.uniq { |d| d.url }
      end

      # @return [Array<String>]
      def keywords
        xpath_result =  xpath_query '/keywordGroups/keywordGroup/keyword/userDefinedKeyword/freeKeyword'
        data_arr = xpath_result.map { |i| i.text.strip }
        data_arr.uniq
      end

      # @return [Array<Puree::Model::LegalCondition>]
      def legal_conditions
        xpath_result = xpath_query '/legalConditions/legalCondition'
        data = []
        xpath_result.each { |i|
          model =  Puree::Model::LegalCondition.new
          model.name = i.xpath('typeClassification/term/localizedString').text.strip
          model.description = i.xpath('description').text.strip
          data << model
        }
        data.uniq { |d| d.name }
      end

      # @return [Array<Puree::Model::Link>]
      def links
        xpath_result = xpath_query '/links/link'
        data = []
        xpath_result.each { |i|
          model =  Puree::Model::Link.new
          model.description = i.xpath('description').text.strip
          model.url = i.xpath('url').text.strip
          data << model
        }
        data.uniq { |d| d.url }
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/organisation'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result
      end

      # @return [Puree::Model::OrganisationHeader, nil]
      def owner
        xpath_result = xpath_query '/managedBy'
        Puree::XMLExtractor::Shared.organisation_header xpath_result
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_internal
        persons 'internal'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other'
      end

      # Date of data production
      # @return [Puree::Model::TemporalRange, nil]
      def production
        temporal_range 'dateOfDataProduction', 'endDateOfDataProduction'
      end

      # @return [Array<Puree::Model::RelatedContentHeader>]
      def projects
        associated_type('Research').uniq
      end

      # @return [Array<Puree::Model::RelatedContentHeader>]
      def publications
        data_arr = []
        associated.each do |i|
          if i.type != 'Research'
            data_arr << i
          end
        end
        data_arr
      end

      # @return [String, nil]
      def publisher
        xpath_query_for_single_value '/publisher/name'
      end

      # @return [Array<String>]
      def spatial_places
        # Data from free-form text box
        xpath_result = xpath_query '/geographicalCoverage/localizedString'
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
        point = Puree::Model::SpatialPoint.new
        if !xpath_result[0].nil?
          arr = xpath_result.text.split(',')
          point.latitude = arr[0].strip.to_f
          point.longitude = arr[1].strip.to_f
          point
        end
        nil
      end

      # def state
      #   # useful?
      #   /startedWorkflow/state
      # end

      # Temporal coverage
      # @return [Puree::Model::TemporalRange, nil]
      def temporal
        temporal_range 'temporalCoverageStartDate', 'temporalCoverageEndDate'
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      private

      def associated_type(type)
        data_arr = []
        associated.each do |i|
          if i.type === type
            related = Puree::Model::RelatedContentHeader.new
            related.type = i.type
            related.title = i.title
            related.uuid = i.uuid
            data_arr << related
          end
        end
        data_arr.uniq
      end

      # @return [Array<Endeavour::Person>]
      def persons(type)
        xpath_result = xpath_query '/persons/dataSetPersonAssociation'
        arr = []
        xpath_result.each do |i|
          uuid_internal = i.at_xpath('person/@uuid')
          uuid_external = i.at_xpath('externalPerson/@uuid')
          if uuid_internal
            person_type = 'internal'
            uuid = uuid_internal.text.strip
          elsif uuid_external
            person_type = 'external'
            uuid = uuid_external.text.strip
          else
            person_type = 'other'
            uuid = ''
          end
          if person_type === type
            person = Puree::Model::EndeavourPerson.new
            person.uuid = uuid

            name = Puree::Model::PersonName.new
            name.first = i.xpath('name/firstName').text.strip
            name.last = i.xpath('name/lastName').text.strip
            person.name = name

            role_uri = i.xpath('personRole/uri').text.strip
            person.role = roles[role_uri]

            arr << person if person.data?
          end
        end
        arr.uniq { |d| d.uuid }
      end

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

      def roles
        {
            '/dk/atira/pure/dataset/roles/dataset/contributor'    => 'Contributor',
            '/dk/atira/pure/dataset/roles/dataset/creator'        => 'Creator',
            '/dk/atira/pure/dataset/roles/dataset/datacollector'  => 'Data Collector',
            '/dk/atira/pure/dataset/roles/dataset/datamanager'    => 'Data Manager',
            '/dk/atira/pure/dataset/roles/dataset/distributor'    => 'Distributor',
            '/dk/atira/pure/dataset/roles/dataset/editor'         => 'Editor',
            '/dk/atira/pure/dataset/roles/dataset/funder'         => 'Funder',
            '/dk/atira/pure/dataset/roles/dataset/owner'          => 'Owner',
            '/dk/atira/pure/dataset/roles/dataset/other'          => 'Other',
            '/dk/atira/pure/dataset/roles/dataset/producer'       => 'Producer',
            '/dk/atira/pure/dataset/roles/dataset/rightsholder'   => 'Rights Holder',
            '/dk/atira/pure/dataset/roles/dataset/sponsor'        => 'Sponsor',
            '/dk/atira/pure/dataset/roles/dataset/supervisor'     => 'Supervisor'
        }
      end

    end

  end

end