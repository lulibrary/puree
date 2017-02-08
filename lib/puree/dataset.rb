module Puree

  # Dataset resource
  #
  class Dataset < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :dataset,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Open access permission
    #
    # @return [String]
    def access
      @metadata['access']
    end

    # Combines project and publication
    #
    # @return [Array<Hash>]
    def associated
      @metadata['associated']
    end

    # Date made available
    #
    # @return [Hash]
    def available
      @metadata['available']
    end

    # Description
    #
    # @return [String]
    def description
      @metadata['description']
    end

    # Digital Object Identifier
    #
    # @return [String]
    def doi
      @metadata['doi']
    end

    # Supporting file
    #
    # @return [Array<Hash>]
    def file
      @metadata['file']
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      @metadata['keyword']
    end

    # Link
    #
    # @return [Array<Hash>]
    def link
      @metadata['link']
    end

    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
      @metadata['organisation']
    end

    # Owner
    #
    # @return [Hash]
    def owner
      @metadata['owner']
    end

    # Person (internal, external, other)
    #
    # @return [Array<Hash>]
    def person
      @metadata['person']
    end

    # Date of data production
    #
    # @return [Hash]
    def production
      @metadata['production']
    end

    # Project
    #
    # @return [Array<Hash>]
    def project
      @metadata['project']
    end

    # Publication
    #
    # @return [Array<Hash>]
    def publication
      @metadata['publication']
    end

    # Publisher
    #
    # @return [String]
    def publisher
      @metadata['publisher']
    end

    # Spatial coverage (place names)
    #
    # @return [Array<String>]
    def spatial
      @metadata['spatial']
    end

    # Spatial coverage point
    #
    # @return [Hash]
    def spatial_point
      @metadata['spatial_point']
    end

    # Temporal coverage
    #
    # @return [Hash]
    def temporal
      @metadata['temporal']
    end

    # Title
    #
    # @return [String]
    def title
      @metadata['title']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end

    private

    def extract_access
      xpath_query_for_single_value '/openAccessPermission/term/localizedString'
    end

    def extract_associated
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

    def extract_available
      temporal_date 'dateMadeAvailable'
    end

    def extract_description
      path = '/descriptions/classificationDefinedField/value/localizedString'
      xpath_query_for_single_value path
    end

    def extract_doi
      xpath_query_for_single_value '/doi'
    end

    def extract_file
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

    def extract_keyword
      xpath_result =  xpath_query '/keywordGroups/keywordGroup/keyword/userDefinedKeyword/freeKeyword'
      data_arr = xpath_result.map { |i| i.text.strip }
      data_arr.uniq
    end

    def extract_link
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

    def extract_organisation
      xpath_result = xpath_query '/organisations/organisation'
      Puree::Extractor::Generic.multi_header xpath_result
    end

    def extract_owner
      xpath_result = xpath_query '/managedBy'
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['name'] = xpath_result.xpath('name/localizedString').text.strip
      o['type'] = xpath_result.xpath('typeClassification/term/localizedString').text.strip
      o
    end

    def extract_person
      data = {}
      xpath_result = xpath_query '/persons/dataSetPersonAssociation'
      internal = []
      external = []
      other = []

      xpath_result.each do |i|
        o = {}
        name = {}
        name['first'] = i.xpath('name/firstName').text.strip
        name['last'] = i.xpath('name/lastName').text.strip
        o['name'] = name
        roles = {
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

    def extract_production
      temporal_range 'dateOfDataProduction', 'endDateOfDataProduction'
    end

    def extract_project
      associated_type('Research').uniq
    end

    def extract_publication
      data_arr = []
      extract_associated.each do |i|
        if i['type'] != 'Research'
          data_arr << i
        end
      end
      data_arr.uniq
    end

    def extract_publisher
      xpath_query_for_single_value '/publisher/name'
    end

    def extract_spatial
      # Data from free-form text box
      xpath_result = xpath_query '/geographicalCoverage/localizedString'
      data = []
      xpath_result.each do |i|
        data << i.text.strip
      end
      data
    end

    def extract_spatial_point
      xpath_result = xpath_query '/geoLocation/point'
      o = {}
      if !xpath_result[0].nil?
        arr = xpath_result.text.split(',')
        o['latitude'] = arr[0].strip.to_f
        o['longitude'] = arr[1].strip.to_f
      end
      o
    end

    def extract_temporal
      temporal_range 'temporalCoverageStartDate', 'temporalCoverageEndDate'
    end

    def extract_title
      xpath_query_for_single_value '/title/localizedString'
    end

    # def state
    #   # useful?
    #   data = node 'startedWorkflows'
    #    !data.empty? ? data['startedWorkflow']['state'] : ''
    # end

    def combine_metadata
      o = super
      o['access'] = extract_access
      o['associated'] = extract_associated
      o['available'] = extract_available
      o['description'] = extract_description
      o['doi'] = extract_doi
      o['file'] = extract_file
      o['keyword'] = extract_keyword
      o['link'] = extract_link
      o['organisation'] = extract_organisation
      o['owner'] = extract_owner
      o['person'] = extract_person
      o['project'] = extract_project
      o['production'] = extract_production
      o['publication'] = extract_publication
      o['publisher'] = extract_publisher
      o['spatial'] = extract_spatial
      o['spatial_point'] = extract_spatial_point
      o['temporal'] = extract_temporal
      o['title'] = extract_title
      @metadata = o
    end

    # Temporal range
    #
    # @return [Hash]
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
      data
    end

    # Temporal coverage date
    #
    # @return [Hash]
    def temporal_date(node)
      path = "/#{node}"
      xpath_result = xpath_query path
      o = {}
      o['day'] = xpath_result.xpath('day').text.strip
      o['month'] = xpath_result.xpath('month').text.strip
      o['year'] = xpath_result.xpath('year').text.strip
      Puree::Date.normalise o
    end

    # Associated type
    #
    # @return [Hash]
    def associated_type(type)
      associated_arr = extract_associated
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

  end

end