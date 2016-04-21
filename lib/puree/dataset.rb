module Puree
  class Dataset < Resource

     def initialize(endpoint, username, password)
       super(endpoint, username, password, :dataset)
     end

      def title
        data = node 'title'
        data ? data['localizedString']["__content__"] : nil
      end

     def keywords
       data = node 'keywordGroups'
       if data
         words = data['keywordGroup']['keyword']['userDefinedKeyword']['freeKeyword']
         words.is_a?(Array) ? words : words.split(',')
       else
         nil
       end
     end

     def description
       data = node 'descriptions'
       data ? data['classificationDefinedField']['value']['localizedString']['__content__'].tr("\n",'') : nil
     end

      def persons
        data = node('persons')
        if data
          data = data['dataSetPersonAssociation']
        else
          return nil
        end
        people = {}
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
        if data
          publications = []
          o = {}
          d = data['relatedContent']
          o['type'] = d['typeClassification']
          o['title'] = d['title']
          o['uuid'] = d['uuid']
          publications << o
        else
          nil
        end
      end

      def dateMadeAvailable
        node('dateMadeAvailable')
      end

      def geographicalCoverage
        data = node 'geographicalCoverage'
        data ? data['localizedString']["__content__"] : nil
      end

      def temporalCoverageStartDate
        node('temporalCoverageStartDate')
      end

      def temporalCoverageEndDate
        node('temporalCoverageEndDate')
      end

      def openAccessPermission
        data = node 'openAccessPermission'
        data ? data['term']['localizedString']["__content__"] : nil
      end

     def documents
       data = node 'documents'
       if data
         docs = []
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
         docs
       else
         nil
       end
     end

     def doi
       data = node 'doi'
       data ? data['doi'] : nil
     end

     # def state
     #   # useful?
     #   data = node 'startedWorkflows'
     #   data ? data['startedWorkflow']['state'] : nil
     # end

     private

     def genericPerson(genericData)
       person = {}
       person['name'] = genericData['name']
       person['role'] = genericData['personRole']['term']['localizedString']["__content__"]
       person
     end
  end
end