module Puree

  # Dataset resource
  #
  class Dataset < Resource

    def initialize
      super(:dataset)
    end

    # Link
    #
    # @return [Array<Hash>]
    def link
      path = '//links/link'
      xpath_result =  xpath_query path
      data = []
      xpath_result.each { |i|
        o = {}
        o['url'] = i.xpath('url').text
        o['description'] = i.xpath('description').text
        data << o
      }
      return data.uniq
    end

    # Publisher
    #
    # @return [String]
    def publisher
      path = '//publisher/name'
      xpath_result =  xpath_query path
      xpath_result ? xpath_result.text : ''
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
        data['type'] = i.xpath('typeClassification').text
        data['title'] = i.xpath('title').text
        data['uuid'] = i.attr('uuid')
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
    # @return [Array<String>]
    def title
      data = node 'title'
      data_arr = []
      if !data.nil? && !data.empty?
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data_arr = data : data_arr << data
      end
      data_arr.uniq
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      data = node 'keywordGroups'
      data_arr = []
      if !data.nil? && !data.empty?
        data = data['keywordGroup']['keyword']['userDefinedKeyword']['freeKeyword']
        data.is_a?(Array) ? data_arr = data : data_arr << data
      end
      data_arr.uniq
    end

    # Description
    #
    # @return [Array<String>]
    def description
      data = node 'descriptions'
      data_arr = []
      if !data.nil? && !data.empty?
        data = data['classificationDefinedField']['value']['localizedString']['__content__'].tr("\n", '')
        data.is_a?(Array) ? data_arr = data : data_arr << data
      end
      data_arr.uniq
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
              person['uuid'] = d['person']['uuid']
              internal_persons << person
            end
            if d.key? 'externalPerson'
              person['uuid'] = d['externalPerson']['uuid']
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
            person['uuid'] = data['person']['uuid']
            internal_persons << person
          end
          if data.key? 'externalPerson'
            person['uuid'] = data['externalPerson']['uuid']
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
      !data.nil? && !data.empty? ? data['term']['localizedString']["__content__"] : ''
    end


    # Supporting file
    #
    # @return [Array<Hash>]
    def file
      data = node 'documents'

      docs = []
      if !data.nil? && !data.empty?
        # convert to array
        data_arr = []
        if data['document'].is_a?(Array)
          data_arr = data['document']
        else
          data_arr << data['document']
        end

        data_arr.each do |d|
          doc = {}
          # doc['id'] = d['id']
          doc['name'] = d['fileName']
          doc['mime'] = d['mimeType']
          doc['size'] = d['size']
          doc['url'] = d['url']
          doc['title'] = d['title']
          # doc['createdDate'] = doc['createdDate']
          # doc['visibleOnPortalDate'] = doc['visibleOnPortalDate']
          # doc['limitedVisibility'] = doc['limitedVisibility']

          license = {}
          if d['documentLicense']
            license_name = d['documentLicense']['term']['localizedString']['__content__']
            license['name'] = license_name
            license_url = d['documentLicense']['description']['localizedString']['__content__']
            license['url'] = license_url
            doc['license'] = license
          end
          docs << doc

        end
      end
      docs.uniq
    end

    # Digital Object Identifier
    #
    # @return [String]
    def doi
      data = node 'doi'
      !data.nil? && !data.empty? ? data['doi'] : ''
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
      o = {}
      o['access'] = access
      o['associated'] = associated
      o['available'] = available
      o['description'] = description
      o['doi'] = doi
      o['file'] = file
      o['geographical'] = geographical
      o['keyword'] = keyword
      o['link'] = link
      o['person'] = person
      o['project'] = project
      o['production'] = production
      o['publication'] = publication
      o['publisher'] = publisher
      o['temporal'] = temporal
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