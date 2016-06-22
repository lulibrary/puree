module Puree

  # Project resource
  #
  class Project < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional basic_auth [Boolean]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :project,
            endpoint: endpoint,
            username: username,
            password: password,
            bleeding: false,
            basic_auth: basic_auth)
    end



    # Acronym
    #
    # @return [String]
    def acronym
      path = '/acronym'
      xpath_query_for_single_value path
    end

    # Description
    #
    # @return [String]
    def description
      path = '/description/localizedString'
      xpath_query_for_single_value path
    end

    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
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

    # Owner
    #
    # @return [Hash]
    def owner
      path = '/owner'
      xpath_result =  xpath_query path
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['name'] = xpath_result.xpath('name/localizedString').text.strip
      o['type'] = xpath_result.xpath('typeClassification/term/localizedString').text.strip
      o
    end

    # Person (internal, external, other)
    #
    # @return [Array<Hash>]
    def person
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
          o['uuid'] = uuid_internal
          internal << o
        elsif uuid_external
          o['uuid'] = uuid_external
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

    # Status
    #
    # @return [String]
    def status
      path = '/status/term/localizedString'
      xpath_query_for_single_value path
    end

    # Temporal, expected and actual start and end dates as UTC datetime.
    #
    # @return [Hash]
    def temporal
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

    # Title
    #
    # @return [String]
    def title
      path = '/title/localizedString'
      xpath_query_for_single_value path
    end

    # Type
    #
    # @return [String]
    def type
      path = '/typeClassification/term/localizedString'
      xpath_query_for_single_value path
    end

    # URL
    #
    # @return [String]
    def url
      path = '/projectURL'
      xpath_query_for_single_value path
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['acronym'] = acronym
      o['description'] = description
      o['organisation'] = organisation
      o['owner'] = owner
      o['person'] = person
      o['status'] = status
      o['temporal'] = temporal
      o['title'] = title
      o['type'] = type
      o['url'] = url
      o
    end

  end

end
