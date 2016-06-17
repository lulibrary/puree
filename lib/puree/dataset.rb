module Puree

  # Dataset resource
  #
  class Dataset < Resource

    # attr_reader :access,
    #             :access,
    #             :associated,
    #             :description,
    #             :doi,
    #             :file,
    #             :geographical,
    #             :keyword,
    #             :link,
    #             :keyword,
    #             :owner,
    #             :person,
    #             :production,
    #             :project,
    #             :publication,
    #             :publisher,
    #             :temporal

    # @return [String]
    # attr_reader  :title

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional basic_auth [Boolean]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :dataset,
            endpoint: endpoint,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end


    # Link
    #
    # @return [Array<Hash>]
    def link
      path = '//links/link'
      xpath_result = xpath_query path
      data = []
      xpath_result.each { |i|
        o = {}
        o['url'] = i.xpath('url').text.strip
        o['description'] = i.xpath('description').text.strip
        data << o
      }
      data.uniq
    end

    # Owner
    #
    # @return [Hash]
    def owner
      path = '//content/managedBy'
      xpath_result =  xpath_query path
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['name'] = xpath_result.xpath('name/localizedString').text.strip
      o['type'] = xpath_result.xpath('typeClassification/term/localizedString').text.strip
       o
    end

    # Publisher
    #
    # @return [String]
    def publisher
      path = '//publisher/name'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Combines project and publication
    #
    # @return [Hash]
    def associated
      path = '//associatedContent//relatedContent'
      xpath_result =  xpath_query path
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

    # Project
    #
    # @return [Array<Hash>]
    def project
      associated_type('Research').uniq
    end

    # Publication
    #
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


    # Title
    #
    # @return [String]
    def title
      path = '//title/localizedString'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      path = '//keywordGroups/keywordGroup/keyword/userDefinedKeyword/freeKeyword'
      xpath_result =  xpath_query path
      data_arr = xpath_result.map { |i| i.text.strip }
      data_arr.uniq
    end

    # Description
    #
    # @return [String]
    def description
      path = '//descriptions/classificationDefinedField/value/localizedString'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Person (internal, external, other)
    #
    # @return [Hash]
    def person
      data = node('persons')
      persons = {}
      if !data.nil? && !data.empty?
        data = data['dataSetPersonAssociation']
      else
        return persons
      end
      internal_persons = []
      external_persons = []
      other_persons = []
      case data
        when Array
          data.each do |d|
            person = generic_person d
            if d.key? 'person'
              person['uuid'] = d['person']['uuid'].strip
              internal_persons << person
            end
            if d.key? 'externalPerson'
              person['uuid'] = d['externalPerson']['uuid'].strip
              external_persons << person
            end
            if !d.key?('person') && !d.key?('externalPerson')
              person['uuid'] = ''
              other_persons << person
            end
          end
        when Hash
          person = generic_person data
          if data.key? 'person'
            person['uuid'] = data['person']['uuid'].strip
            internal_persons << person
          end
          if data.key? 'externalPerson'
            person['uuid'] = data['externalPerson']['uuid'].strip
            external_persons << person
          end
          if !data.key?('person') && !data.key?('externalPerson')
            person['uuid'] = ''
            other_persons << person
          end
      end
      persons['internal'] = internal_persons.uniq
      persons['external'] = external_persons.uniq
      persons['other'] = other_persons.uniq
      persons
    end



    # Date made available
    #
    # @return [Hash]
    def available
      data = node('dateMadeAvailable')
      Puree::Date.normalise(data)
    end

    # Geographical coverage
    #
    # @return [Array<String>]
    def geographical
      data = node 'geographicalCoverage'
      if !data.nil? && !data.empty?
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data.uniq : data.split(',').map(&:strip).uniq
      else
        []
      end
    end

    # Date of data production
    #
    # @return [Hash]
    def production
      temporal_range 'dateOfDataProduction', 'endDateOfDataProduction'
    end


    # Temporal coverage
    #
    # @return [Hash]
    def temporal
      temporal_range 'temporalCoverageStartDate', 'temporalCoverageEndDate'
    end

    # Open access permission
    #
    # @return [String]
    def access
      data = node 'openAccessPermission'
      !data.nil? && !data.empty? ? data['term']['localizedString']["__content__"].strip : ''
    end


    # Supporting file
    #
    # @return [Array<Hash>]
    def file
      path = '//documents/document'
      xpath_result = xpath_query path

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

    # Digital Object Identifier
    #
    # @return [String]
    def doi
      path = '//content/doi'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # def state
    #   # useful?
    #   data = node 'startedWorkflows'
    #    !data.empty? ? data['startedWorkflow']['state'] : ''
    # end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      # access
      o['access'] = access
      # associated
      o['associated'] = associated
      # available
      o['available'] = available
      # description
      o['description'] = description
      # doi
      o['doi'] = doi
      # file
      o['file'] = file
      # geographical
      o['geographical'] = geographical
      # keyword
      o['keyword'] = keyword
      # link
      o['link'] = link
      # owner
      o['owner'] = owner
      # person
      o['person'] = person
      # project
      o['project'] = project
      # production
      o['production'] = production
      # publication
      o['publication'] = publication
      # publisher
      o['publisher'] = publisher
      # temporal
      o['temporal'] = temporal
      # title
      o['title'] = title
      o
    end

    private

    # Assembles basic information about a person
    #
    # @param generic_data [Hash]
    # @return [Hash]
    def generic_person(generic_data)
      person = {}
      name = {}
      name['first'] = generic_data['name']['firstName']
      name['last'] = generic_data['name']['lastName']
      person['name'] = name
      person['role'] = generic_data['personRole']['term']['localizedString']["__content__"]
      person
    end

    # Temporal range
    #
    # @return [Hash]
    def temporal_range(start_node, end_node)
      data = {}
      data['start'] = {}
      data['end'] = {}
      start_date = temporal_start_date start_node
      if !start_date.nil? && !start_date.empty?
        data['start'] = start_date
      end
      end_date = temporal_end_date end_node
      if !end_date.nil? && !end_date.empty?
        data['end'] = end_date
      end
      data
    end

    # Temporal coverage start date
    #
    # @return [Hash]
    def temporal_start_date(start_node)
      data = node start_node
      !data.nil? && !data.empty? ? Puree::Date.normalise(data) : {}
    end

    # Temporal coverage end date
    #
    # @return [Hash]
    def temporal_end_date(end_node)
      data = node end_node
      !data.nil? && !data.empty? ? Puree::Date.normalise(data) : {}
    end

    # Associated type
    #
    # @return [Hash]
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

  end

end