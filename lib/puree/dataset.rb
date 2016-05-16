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
      internal_persons = []
      external_persons = []
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
      end
      persons['internal'] = internal_persons
      persons['external'] = external_persons
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
        data_arr = []
        if data['relatedContent'].is_a?(Array)
          data_arr = data['relatedContent']
        else
          data_arr[0] = data['relatedContent']
        end
        data_arr.each do |d|
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

    # Date of data production
    #
    # @return [Hash]
    def production
      data = node('dateOfDataProduction')
      Puree::Date.normalise(data)
    end

    # Temporal coverage
    #
    # @return [Hash]
    def temporal
      data = {}
      data['start'] = {}
      data['end'] = {}
      start_date = temporal_coverage_start_date
      if !start_date.nil? && !start_date.empty?
        data['start'] = start_date
      end
      end_date = temporal_coverage_end_date
      if !end_date.nil? && !end_date.empty?
        data['end'] = end_date
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
      o['access'] = access
      o['available'] = available
      o['description'] = description
      o['doi'] = doi
      o['file'] = file
      o['geographical'] = geographical
      o['keyword'] = keyword
      o['person'] = person
      o['production'] = production
      o['publication'] = publication
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

    # Temporal coverage start date
    #
    # @return [Hash]
    def temporal_coverage_start_date
      data = node('temporalCoverageStartDate')
      !data.nil? && !data.empty? ? Puree::Date.normalise(data) : {}
    end

    # Temporal coverage end date
    #
    # @return [Hash]
    def temporal_coverage_end_date
      data = node('temporalCoverageEndDate')
      !data.nil? && !data.empty? ? Puree::Date.normalise(data) : {}
    end
  end
end