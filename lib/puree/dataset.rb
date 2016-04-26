module Puree

  # Dataset resource.
  #
  class Dataset < Resource

    # @param [String] endpoint
    # @param [String] username
    # @param [String] password
    def initialize(endpoint, username, password)
      super(endpoint, username, password, :dataset)
    end

    # Titles
    #
    # @return [Array<String>]
    def titles
      data = node 'title'
      if !data.nil? && !data.empty?
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # Keywords
    #
    # @return [Array<String>]
    def keywords
      data = node 'keywordGroups'
      if !data.nil? && !data.empty?
        data = data['keywordGroup']['keyword']['userDefinedKeyword']['freeKeyword']
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # Descriptions
    #
    # @return [Array<String>]
    def descriptions
      data = node 'descriptions'
      if !data.nil? && !data.empty?
        data = data['classificationDefinedField']['value']['localizedString']['__content__'].tr("\n", '')
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # People, internal and external
    #
    # @return [Hash<Array, Array>]
    def people
      data = node('persons')
      persons = {}
      if !data.nil? && !data.empty?
        data = data['dataSetPersonAssociation']
      else
        return persons
      end
      internalPersons = []
      externalPersons = []
      case data
        when Array
          data.each do |d|
            person = genericPerson d
            if d.key? 'person'
              person['uuid'] = d['person']['uuid']
              internalPersons << person
            end
            if d.key? 'externalPerson'
              person['uuid'] = d['externalPerson']['uuid']
              externalPersons << person
            end
          end
        when Hash
          person = genericPerson data
          if data.key? 'person'
            person['uuid'] = data['person']['uuid']
            internalPersons << person
          end
          if data.key? 'externalPerson'
            person['uuid'] = data['externalPerson']['uuid']
            externalPersons << person
          end
      end
      persons['internal'] = internalPersons
      persons['external'] = externalPersons
      persons
    end

    # Related publications
    #
    # @return [Array<Hash>]
    def publications
      data = node('relatedPublications')
      publications = []
      if !data.nil? && !data.empty?
        o = {}
        d = data['relatedContent']
        o['type'] = d['typeClassification']
        o['title'] = d['title']
        o['uuid'] = d['uuid']
        publications << o
      end
      publications
    end

    # Date made available
    #
    # @return [Hash]
    def available
      data = node('dateMadeAvailable')
      !data.nil? && !data.empty? ? data : {}
    end

    # Geographical coverage
    #
    # @return [Array<String>]
    def geographical
      data = node 'geographicalCoverage'
      if !data.nil? && !data.empty?
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # Temporal coverage
    #
    # @return [Hash]
    def temporal
      data = {}
      data['start'] = {}
      data['end'] = {}
      startDate = temporalCoverageStartDate
      if !startDate.nil? && !startDate.empty?
        data['start'] = startDate
      end
      endDate = temporalCoverageEndDate
      if !endDate.nil? && !endDate.empty?
        data['end'] = endDate
      end
      data
    end

    # Open access permission
    #
    # @return [String]
    def access
      data = node 'openAccessPermission'
      !data.nil? && !data.empty? ? data['term']['localizedString']["__content__"] : ''
    end

    # Supporting files
    #
    # @return [Array<Hash>]
    def files
      data = node 'documents'
      docs = []
      if !data.nil? && !data.empty?
        data['document'].each do |d|
          doc = {}
          # doc['id'] = d['id']
          doc['filename'] = d['fileName']
          doc['mimeType'] = d['mimeType']
          doc['size'] = d['size']
          doc['url'] = d['url']
          doc['title'] = d['title']
          # doc['createdDate'] = doc['createdDate']
          # doc['visibleOnPortalDate'] = doc['visibleOnPortalDate']
          # doc['limitedVisibility'] = doc['limitedVisibility']
          license = {}
          license['name'] = d['documentLicense']['term']['localizedString']['__content__']
          license['url'] = d['documentLicense']['description']['localizedString']['__content__']
          doc['license'] = license
          docs << doc
        end
      end
      docs
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
    def all
      o = {}
      o['titles'] = titles
      o['descriptions'] = descriptions
      o['keywords'] = keywords
      o['people'] = people
      o['temporal'] = temporal
      o['geographical'] = geographical
      o['files'] = files
      o['publications'] = publications
      o['available'] = available
      o['access'] = access
      o['doi'] = doi
      o
    end

    private

    def genericPerson(genericData)
      person = {}
      name = {}
      name['first'] = genericData['name']['firstName']
      name['last'] = genericData['name']['lastName']
      person['name'] = name
      person['role'] = genericData['personRole']['term']['localizedString']["__content__"]
      person
    end

    # Temporal coverage start date
    #
    # @return [Hash]
    def temporalCoverageStartDate
      data = node('temporalCoverageStartDate')
      !data.nil? && !data.empty? ? data : {}
    end

    # Temporal coverage end date
    #
    # @return [Hash]
    def temporalCoverageEndDate
      data = node('temporalCoverageEndDate')
      !data.nil? && !data.empty? ? data : {}
    end
  end
end