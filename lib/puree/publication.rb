module Puree

  # Publication resource
  #
  class Publication < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :publication,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Category
    #
    # @return [String]
    def category
      @metadata['category']
    end

    # Description
    #
    # @return [String]
    def description
      @metadata['description']
    end

    # Event
    #
    # @return [Hash]
    def event
      @metadata['event']
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

    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
      @metadata['organisation']
    end

    # Page
    #
    # @return [Array<String>]
    def page
      @metadata['page']
    end

    # Person (internal, external, other)
    #
    # @return [Array<Hash>]
    def person
      @metadata['person']
    end

    # Status
    #
    # @return [Array<Hash>]
    def status
      @metadata['status']
    end

    # Title
    #
    # @return [String]
    def title
      @metadata['title']
    end

    # Subtitle
    #
    # @return [String]
    def subtitle
      @metadata['subtitle']
    end

    # Type
    #
    # @return [String]
    def type
      @metadata['type']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    def extract_category
      path = '/publicationCategory/publicationCategory/term/localizedString'
      xpath_query_for_single_value path
    end

    def extract_description
      path = '/abstract/localizedString'
      xpath_query_for_single_value path
    end

    def extract_event
      path = '/event'
      xpath_result = xpath_query path
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['title'] = xpath_result.xpath('title/localizedString').text.strip
      o
    end

    def extract_doi
      path = '//doi'
      xpath_query_for_single_value path
    end

    def extract_file
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

    def extract_page
      path = '/numberOfPages'
      xpath_query_for_single_value path
    end

    def extract_person
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

    def extract_status
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

    def extract_title
      path = '/title'
      xpath_query_for_single_value path
    end

    def extract_subtitle
      path = '/subtitle'
      xpath_query_for_single_value path
    end

    def extract_type
      path = '/typeClassification/term/localizedString'
      xpath_query_for_single_value path
    end

    def combine_metadata
      o = super
      o['category'] = extract_category
      o['description'] = extract_description
      o['doi'] = extract_doi
      o['event'] = extract_event
      o['file'] = extract_file
      o['organisation'] = extract_organisation
      o['page'] = extract_page
      o['person'] = extract_person
      o['status'] = extract_status
      o['subtitle'] = extract_subtitle
      o['title'] = extract_title
      o['type'] = extract_type
      @metadata = o
    end

  end

end
