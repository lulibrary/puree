module Puree

  module XMLExtractor

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
        xpath_result = xpath_query '/associatedContent//relatedContent'
        data_arr = []
        xpath_result.each { |i|
          related = Puree::Model::RelatedContentHeader.new
          related.type = i.xpath('typeClassification').text.strip
          related.title = i.xpath('title').text.strip
          related.uuid = i.attr('uuid').strip
          data_arr << related
        }
        data_arr.uniq
      end

      # Date made available
      # @return [Time]
      def available
        Puree::Util::Date.hash_to_time temporal_date('dateMadeAvailable')
      end

      # Digital Object Identifier
      # @return [String, nil]
      def doi
        xpath_query_for_single_value '/doi'
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/descriptions/classificationDefinedField/value/localizedString'
      end

      # Supporting files
      # @return [Array<Puree::Model::File>]
      def files
        xpath_result = xpath_query '/documents/document'
        docs = []
        xpath_result.each do |d|
          doc = Puree::Model::File.new
          doc_name = d.xpath('fileName').text.strip
          doc.name = doc_name unless doc_name.empty?
          doc_mime = d.xpath('mimeType').text.strip
          doc.mime = doc_mime unless doc_mime.empty?
          doc_size = d.xpath('size').text.strip
          doc.size = doc_size unless doc_size.empty?
          doc_url = d.xpath('url').text.strip
          doc.url = doc_url unless doc_url.empty?
          # doc['createdDate'] = d.xpath('createdDate').text.strip
          # doc['visibleOnPortalDate'] = d.xpath('visibleOnPortalDate').text.strip
          # doc['limitedVisibility'] = d.xpath('limitedVisibility').text.strip
          license = Puree::Model::CopyrightLicense.new
          license_name = d.xpath('documentLicense/term/localizedString').text.strip
          license.name = license_name unless license_name.empty?
          license_url = d.xpath('documentLicense/description/localizedString').text.strip
          license.url = license_url unless license_url.empty?
          doc.license = license
          docs << doc
        end
        docs.uniq
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
        data.uniq
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
        data.uniq
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Puree::Model::OrganisationHeader]
      def owner
        xpath_result = xpath_query '/managedBy'
        Puree::XMLExtractor::Shared.header xpath_result
      end

      # Internal persons
      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_internal
        persons 'internal'
      end

      # External persons
      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external'
      end

      # Other persons
      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other'
      end

      # Date of data production
      # @return [Puree::Model::TemporalRange]
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
          if i['type'] != 'Research'
            data_arr << i
          end
        end
        data_arr.uniq
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
        data
      end

      # Spatial coverage point
      # @return [Puree::Model::SpatialPoint]
      def spatial_point
        xpath_result = xpath_query '/geoLocation/point'
        if !xpath_result[0].nil?
          arr = xpath_result.text.split(',')
          point = Puree::Model::SpatialPoint.new
          point.latitude = arr[0].strip.to_f
          point.longitude = arr[1].strip.to_f
        end
      end

      # def state
      #   # useful?
      #   /startedWorkflow/state
      # end

      # Temporal coverage
      # @return [Puree::Model::TemporalRange]
      def temporal
        temporal_range 'temporalCoverageStartDate', 'temporalCoverageEndDate'
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      private

      def associated_type(type)
        associated_arr = associated
        data_arr = []
        associated_arr.each do |i|
          data = {}
          if i['type'] === type
            data['title'] = i['title']
            data['uuid'] = i['uuid']
            data_arr << data
          end
        end
        data_arr
      end

      # @return [Array<Endeavour::Person>]
      def persons(type)
        xpath_result = xpath_query '/persons/dataSetPersonAssociation'
        arr = []
        xpath_result.each do |i|
          person = Puree::Model::EndeavourPerson.new

          name = Puree::Model::PersonName.new
          name.first = i.xpath('name/firstName').text.strip
          name.last = i.xpath('name/lastName').text.strip
          person.name = name

          role_uri = i.xpath('personRole/uri').text.strip
          person.role = roles[role_uri].to_s

          if type === 'internal'
            uuid = i.at_xpath('person/@uuid')
          elsif type === 'external'
            uuid = i.at_xpath('externalPerson/@uuid')
          elsif type === 'other'
            uuid = nil
          end
          if uuid
            uuid = uuid.text.strip
          end
          person.uuid = uuid

          arr << person
        end
        arr
      end

      # Temporal range
      # @return [Puree::Model::TemporalRange]
      def temporal_range(start_node, end_node)
        data = {}
        data['start'] = {}
        data['end'] = {}
        start_date = temporal_date start_node
        range = Puree::Model::TemporalRange.new
        if !start_date['year'].empty?
          range.start = Puree::Util::Date.hash_to_time start_date
        end
        end_date = temporal_date end_node
        if !end_date['year'].empty?
          range.end = Puree::Util::Date.hash_to_time end_date
        end
        range
      end

      # Temporal coverage date
      # @return [Hash]
      def temporal_date(node)
        path = "/#{node}"
        xpath_result = xpath_query path
        o = {}
        o['day'] = xpath_result.xpath('day').text.strip
        o['month'] = xpath_result.xpath('month').text.strip
        o['year'] = xpath_result.xpath('year').text.strip
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