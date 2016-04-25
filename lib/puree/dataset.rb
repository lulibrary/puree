module Puree
  class Dataset < Resource

    def initialize(endpoint, username, password)
      super(endpoint, username, password, :dataset)
    end

    def title
      data = node 'title'
      if data
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    def keywords
      data = node 'keywordGroups'
      if data
        data = data['keywordGroup']['keyword']['userDefinedKeyword']['freeKeyword']
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    def description
      data = node 'descriptions'
      if data
        data = data['classificationDefinedField']['value']['localizedString']['__content__'].tr("\n", '')
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    def persons
      data = node('persons')
      people = {}
      if data
        data = data['dataSetPersonAssociation']
      else
        return people
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
      people['internal'] = internalPersons
      people['external'] = externalPersons
      people
    end

    def relatedPublications
      data = node('relatedPublications')
      publications = []
      if data
        o = {}
        d = data['relatedContent']
        o['type'] = d['typeClassification']
        o['title'] = d['title']
        o['uuid'] = d['uuid']
        publications << o
      end
      publications
    end

    def dateMadeAvailable
      data = node('dateMadeAvailable')
      data ? data : {}
    end

    def geographicalCoverage
      data = node 'geographicalCoverage'
      if data
        data = data['localizedString']["__content__"]
        data.is_a?(Array) ? data : data.split(',')
      else
        []
      end
    end

    def temporalCoverageStartDate
      data = node('temporalCoverageStartDate')
      data ? data : {}
    end

    def temporalCoverageEndDate
      data = node('temporalCoverageEndDate')
      data ? data : {}
    end

    def openAccessPermission
      data = node 'openAccessPermission'
      data ? data['term']['localizedString']["__content__"] : ''
    end

    def documents
      data = node 'documents'
      docs = []
      if data
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

    def doi
      data = node 'doi'
      data ? data['doi'] : ''
    end

    # def state
    #   # useful?
    #   data = node 'startedWorkflows'
    #   data ? data['startedWorkflow']['state'] : nil
    # end

    def all
      o = {}
      o['title'] = title
      o['description'] = description
      o['keywords'] = keywords
      o['persons'] = persons
      o['temporalCoverageStartDate'] = temporalCoverageStartDate
      o['temporalCoverageEndDate'] = temporalCoverageEndDate
      o['geographicalCoverage'] = geographicalCoverage
      o['documents'] = documents
      o['relatedPublications'] = relatedPublications
      o['dateMadeAvailable'] = dateMadeAvailable
      o['openAccessPermission'] = openAccessPermission
      o['doi'] = doi
      o
    end

    private

    def genericPerson(genericData)
      person = {}
      person['name'] = genericData['name']
      person['role'] = genericData['personRole']['term']['localizedString']["__content__"]
      person
    end
  end
end