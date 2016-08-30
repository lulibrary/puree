module Puree

  # Project resource
  #
  class Project < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :project,
            base_url: base_url,
            username: username,
            password: password,
            bleeding: false,
            basic_auth: basic_auth)
    end

    # Acronym
    #
    # @return [String]
    def acronym
      @metadata['acronym']
    end

    # Description
    #
    # @return [String]
    def description
      @metadata['description']
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

    # Status
    #
    # @return [String]
    def status
      @metadata['status']
    end

    # Temporal, expected and actual start and end dates as UTC datetime.
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

    # Type
    #
    # @return [String]
    def type
      @metadata['type']
    end

    # URL
    #
    # @return [String]
    def url
      @metadata['url']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    def extract_acronym
      path = '/acronym'
      xpath_query_for_single_value path
    end

    def extract_description
      path = '/description/localizedString'
      xpath_query_for_single_value path
    end

    def extract_organisation
      path = '/organisations/association/organisation'
      xpath_result = xpath_query path
      data = []
      xpath_result.each do |i|
        o = {}
        o['uuid'] = i.xpath('@uuid').text.strip
        o['name'] = i.xpath('name/localizedString').text.strip
        o['type'] = i.xpath('typeClassification/term/localizedString').text.strip
        data << o
      end
      data
    end

    def extract_owner
      path = '/owner'
      xpath_result =  xpath_query path
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['name'] = xpath_result.xpath('name/localizedString').text.strip
      o['type'] = xpath_result.xpath('typeClassification/term/localizedString').text.strip
      o
    end

    def extract_person
      data = {}
      # internal
      path = '/persons/participantAssociation'
      xpath_result = xpath_query path
      internal = []
      external = []
      other = []

      xpath_result.each do |i|
        o = {}
        name = {}
        name['first'] = i.xpath('person/name/firstName').text.strip
        name['last'] = i.xpath('person/name/lastName').text.strip
        o['name'] = name
        o['role'] = i.xpath('personRole/term/localizedString').text.strip

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

    def extract_status
      path = '/status/term/localizedString'
      xpath_query_for_single_value path
    end

    def extract_temporal
      o = {}
      o['expected'] = {}
      o['actual'] = {}

      path = '/expectedStartDate'
      xpath_result =  xpath_query path
      o['expected']['start'] = xpath_result.text.strip

      path = '/expectedEndDate'
      xpath_result =  xpath_query path
      o['expected']['end'] = xpath_result.text.strip

      path = '/startFinishDate/startDate'
      xpath_result =  xpath_query path
      o['actual']['start'] = xpath_result.text.strip

      path = '/startFinishDate/endDate'
      xpath_result =  xpath_query path
      o['actual']['end'] = xpath_result.text.strip

      o
    end

    def extract_title
      path = '/title/localizedString'
      xpath_query_for_single_value path
    end

    def extract_type
      path = '/typeClassification/term/localizedString'
      xpath_query_for_single_value path
    end

    def extract_url
      path = '/projectURL'
      xpath_query_for_single_value path
    end

    def combine_metadata
      o = super
      o['acronym'] = extract_acronym
      o['description'] = extract_description
      o['organisation'] = extract_organisation
      o['owner'] = extract_owner
      o['person'] = extract_person
      o['status'] = extract_status
      o['temporal'] = extract_temporal
      o['title'] = extract_title
      o['type'] = extract_type
      o['url'] = extract_url
      @metadata = o
    end

  end

end
