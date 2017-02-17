module Puree

  module XMLExtractor

    class Dataset < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :dataset
      end

      # Open access permission
      # @return [String]
      def access
        xpath_query_for_single_value '/openAccessPermission/term/localizedString'
      end

      # Combines project and publication
      # @return [Array<Hash>]
      def associated
        xpath_result = xpath_query '/associatedContent//relatedContent'
        data_arr = []
        xpath_result.each { |i|
          data = {}
          data['type'] = i.xpath('typeClassification').text.strip
          data['title'] = i.xpath('title').text.strip
          data['uuid'] = i.attr('uuid').strip
          data_arr << data
        }
        data_arr.uniq
      end

      # Date made available
      # @return [Time]
      def available
        Puree::Util::Date.hash_to_time temporal_date('dateMadeAvailable')
      end

      # Digital Object Identifier
      # @return [String]
      def doi
        xpath_query_for_single_value '/doi'
      end

      # @return [String]
      def description
        xpath_query_for_single_value '/descriptions/classificationDefinedField/value/localizedString'
      end

      # Supporting file
      # @return [Array<Hash>]
      def file
        xpath_result = xpath_query '/documents/document'
        docs = []
        xpath_result.each do |d|
          doc = {}
          # doc['id'] = f.xpath('id').text.strip
          doc['name'] = d.xpath('fileName').text.strip
          doc['mime'] = d.xpath('mimeType').text.strip
          doc['size'] = d.xpath('size').text.strip
          doc['url'] = d.xpath('url').text.strip
          doc['title'] = d.xpath('title').text.strip
          # doc['createdDate'] = d.xpath('createdDate').text.strip
          # doc['visibleOnPortalDate'] = d.xpath('visibleOnPortalDate').text.strip
          # doc['limitedVisibility'] = d.xpath('limitedVisibility').text.strip
          license = {}
          license_name = d.xpath('documentLicense/term/localizedString').text.strip
          license['name'] = license_name
          license_url = d.xpath('documentLicense/description/localizedString').text.strip
          license['url'] = license_url
          doc['license'] = license
          docs << doc
        end
        docs.uniq
      end

      # @return [Array<String>]
      def keyword
        xpath_result =  xpath_query '/keywordGroups/keywordGroup/keyword/userDefinedKeyword/freeKeyword'
        data_arr = xpath_result.map { |i| i.text.strip }
        data_arr.uniq
      end

      # @return [Array<Hash>]
      def link
        xpath_result = xpath_query '/links/link'
        data = []
        xpath_result.each { |i|
          o = {}
          o['url'] = i.xpath('url').text.strip
          o['description'] = i.xpath('description').text.strip
          data << o
        }
        data.uniq
      end

      # @return [Array<Hash>]
      def organisation
        xpath_result = xpath_query '/organisations/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Hash]
      def owner
        xpath_result = xpath_query '/managedBy'
        Puree::XMLExtractor::Shared.header xpath_result
      end

      # Person (internal, external, other)
      # @return [Hash<Array,Array,Array>]
      def person
        xpath_result = xpath_query '/persons/dataSetPersonAssociation'
        data = {}
        internal = []
        external = []
        other = []
        xpath_result.each do |i|
          o = {}
          name = {}
          name['first'] = i.xpath('name/firstName').text.strip
          name['last'] = i.xpath('name/lastName').text.strip
          o['name'] = name
          role_uri = i.xpath('personRole/uri').text.strip
          o['role'] = roles[role_uri].to_s
          uuid_internal = i.at_xpath('person/@uuid')
          uuid_external = i.at_xpath('externalPerson/@uuid')
          if uuid_internal
            o['uuid'] = uuid_internal.text.strip
            internal << o
          elsif uuid_external
            o['uuid'] = uuid_external.text.strip
            external << o
          else
            other << o
            o['uuid'] = ''
          end
        end
        data['internal'] = internal
        data['external'] = external
        data['other'] = other
        data
      end

      # Date of data production
      # @return [Hash]
      def production
        temporal_range 'dateOfDataProduction', 'endDateOfDataProduction'
      end

      # @return [Array<Hash>]
      def project
        associated_type('Research').uniq
      end

      # @return [Array<Hash>]
      def publication
        data_arr = []
        associated.each do |i|
          if i['type'] != 'Research'
            data_arr << i
          end
        end
        data_arr.uniq
      end

      # @return [String]
      def publisher
        xpath_query_for_single_value '/publisher/name'
      end

      # Spatial coverage (place names)
      # @return [Array<String>]
      def spatial
        # Data from free-form text box
        xpath_result = xpath_query '/geographicalCoverage/localizedString'
        data = []
        xpath_result.each do |i|
          data << i.text.strip
        end
        data
      end

      # Spatial coverage point
      # @return [Hash]
      def spatial_point
        xpath_result = xpath_query '/geoLocation/point'
        o = {}
        if !xpath_result[0].nil?
          arr = xpath_result.text.split(',')
          o['latitude'] = arr[0].strip.to_f
          o['longitude'] = arr[1].strip.to_f
        end
        o
      end

      # def state
      #   # useful?
      #   /startedWorkflow/state
      # end

      # Temporal coverage
      # @return [Hash]
      def temporal
        temporal_range 'temporalCoverageStartDate', 'temporalCoverageEndDate'
      end

      # @return [String]
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

      # Temporal range
      # @return [Hash<Time,Time>]
      def temporal_range(start_node, end_node)
        data = {}
        data['start'] = {}
        data['end'] = {}
        start_date = temporal_date start_node
        if !start_date.nil? && !start_date.empty?
          data['start'] = start_date
        end
        end_date = temporal_date end_node
        if !end_date.nil? && !end_date.empty?
          data['end'] = end_date
        end
        range = Puree::TemporalRange.new
        range.start = Puree::Util::Date.hash_to_time data['start']
        range.end = Puree::Util::Date.hash_to_time data['end']
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