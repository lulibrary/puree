module Puree

  # Publication resource
  #
  class Publication < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional basic_auth [Boolean]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :publication,
            endpoint: endpoint,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Category
    #
    # @return [String]
    def category
      path = '/publicationCategory/publicationCategory/term/localizedString'
      xpath_query_for_single_value path
    end

    # Description
    #
    # @return [String]
    def description
      path = '/abstract/localizedString'
      xpath_query_for_single_value path
    end

    # Event
    #
    # @return [Hash]
    def event
      path = '/event'
      xpath_result = xpath_query path
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['title'] = xpath_result.xpath('title/localizedString').text.strip
      o
    end

    # Digital Object Identifier
    #
    # @return [String]
    def doi
      path = '//doi'
      xpath_query_for_single_value path
    end

    # Supporting file
    #
    # @return [Array<Hash>]
    def file
      path = '/electronicVersionAssociations/electronicVersionFileAssociations/electronicVersionFileAssociation/file'
      xpath_result = xpath_query path
      docs = []
      xpath_result.each do |d|
        doc = {}
        # doc['id'] = d.xpath('id').text
        doc['name'] = d.xpath('fileName').text.strip
        doc['mime'] = d.xpath('mimeType').text.strip
        doc['size'] = d.xpath('size').text.strip
        doc['url'] = d.xpath('url').text.strip
        docs << doc
      end
      docs.uniq
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

    # Page
    #
    # @return [Array<String>]
    def page
      path = '/numberOfPages'
      xpath_query_for_single_value path
    end

    # Person (internal, external, other)
    #
    # @return [Array<Hash>]
    def person
      data = {}
      # internal
      path = '/persons/personAssociation'
      xpath_result = xpath_query path
      internal = []
      external = []
      other = []

      xpath_result.each do |i|
        o = {}
        name = {}
        name['first'] = i.xpath('name/firstName').text.strip
        name['last'] = i.xpath('name/lastName').text.strip
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
    # @return [Array<Hash>]
    def status
      path = '/publicationStatuses/publicationStatus'
      xpath_result = xpath_query path
      data = []
      xpath_result.each do |i|
        o = {}
        o['stage'] = i.xpath('publicationStatus/term/localizedString').text.strip
        ymd = {}
        ymd['year'] = i.xpath('publicationDate/year').text.strip
        ymd['month'] = i.xpath('publicationDate/month').text.strip
        ymd['day'] = i.xpath('publicationDate/day').text.strip
        o['date'] = Puree::Date.normalise(ymd)
        data << o
      end
      data
    end

    # Title
    #
    # @return [String]
    def title
      path = '/title'
      xpath_query_for_single_value path
    end

    # Subtitle
    #
    # @return [String]
    def subtitle
      path = '/subtitle'
      xpath_query_for_single_value path
    end

    # Type
    #
    # @return [String]
    def type
      path = '/typeClassification/term/localizedString'
      xpath_query_for_single_value path
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['category'] = category
      o['description'] = description
      o['doi'] = doi
      o['event'] = event
      o['file'] = file
      o['organisation'] = organisation
      o['page'] = page
      o['person'] = person
      o['status'] = status
      o['subtitle'] = subtitle
      o['title'] = title
      o['type'] = type
      o
    end

  end

end
