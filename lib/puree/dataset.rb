module Puree

  # Dataset resource
  #
  class Dataset < Resource

    def initialize
      super(:dataset)
    end

    # Title
    #
    # @return [Array<String>]
    def title
      data = node 'title'
      if !data.nil? && !data.empty?
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      data = node 'keywordGroups'
      if !data.nil? && !data.empty?
        data = data['keywordGroup']['keyword']['userDefinedKeyword']['freeKeyword']
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # Description
    #
    # @return [Array<String>]
    def description
      data = node 'descriptions'
      if !data.nil? && !data.empty?
        data = data['classificationDefinedField']['value']['localizedString']['__content__'].tr("\n", '')
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    # Person, internal and external
    #
    # @return [Hash<Array, Array>]
    def person
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

    # Publication
    #
    # @return [Array<Hash>]
    def publication
      data = node('relatedPublications')
      publications = []
      if !data.nil? && !data.empty?
        # convert to array
        dataArr = []
        if data['relatedContent'].is_a?(Array)
          dataArr = data['relatedContent']
        else
          dataArr[0] = data['relatedContent']
        end
        dataArr.each do |d|
          o = {}
          o['type'] = d['typeClassification']
          o['title'] = d['title']
          o['uuid'] = d['uuid']
          publications << o
        end
      end
      publications
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


    # Supporting file
    #
    # @return [Array<Hash>]
    def file
      data = node 'documents'

      docs = []
      if !data.nil? && !data.empty?
        # convert to array
        dataArr = []
        if data['document'].is_a?(Array)
          dataArr = data['document']
        else
          dataArr << data['document']
        end

        dataArr.each do |d|
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
            licenseName = d['documentLicense']['term']['localizedString']['__content__']
            license['name'] = licenseName
            licenseURL = d['documentLicense']['description']['localizedString']['__content__']
            license['url'] = licenseURL
            doc['license'] = license
          end
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
    def metadata
      o = {}
      o['title'] = title
      o['description'] = description
      o['keyword'] = keyword
      o['person'] = person
      o['temporal'] = temporal
      o['geographical'] = geographical
      o['file'] = file
      o['publication'] = publication
      o['available'] = available
      o['access'] = access
      o['doi'] = doi
      o
    end

    private

    # Assembles basic information about a person
    #
    # @param genericData [Hash]
    # @return [Hash]
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
      !data.nil? && !data.empty? ? Puree::Date.normalise(data) : {}
    end

    # Temporal coverage end date
    #
    # @return [Hash]
    def temporalCoverageEndDate
      data = node('temporalCoverageEndDate')
      !data.nil? && !data.empty? ? Puree::Date.normalise(data) : {}
    end
  end
end