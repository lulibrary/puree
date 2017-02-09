module Puree

  # Project resource
  #
  class Project < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :project,
            base_url: base_url,
            username: username,
            password: password,
            bleeding: false, # stable API does not return person roles
            basic_auth: basic_auth)
    end

    # Acronym
    #
    # @return [String]
    def acronym
      @metadata['acronym']
    end

    # Description
    #
    # @return [String]
    def description
      @metadata['description']
    end

    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
      @metadata['organisation']
    end

    # Owner
    #
    # @return [Hash]
    def owner
      @metadata['owner']
    end

    # Person (internal, external, other)
    #
    # @return [Hash<Array,Array,Array>]
    def person
      @metadata['person']
    end

    # Status
    #
    # @return [String]
    def status
      @metadata['status']
    end

    # Temporal, expected and actual start and end dates as UTC datetime.
    #
    # @return [Hash]
    def temporal
      @metadata['temporal']
    end

    # Title
    #
    # @return [String]
    def title
      @metadata['title']
    end

    # Type
    #
    # @return [String]
    def type
      @metadata['type']
    end

    # URL
    #
    # @return [String]
    def url
      @metadata['url']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    def extract_acronym
      xpath_query_for_single_value '/acronym'
    end

    def extract_description
      xpath_query_for_single_value '/description/localizedString'
    end

    def extract_organisation
      xpath_result = xpath_query '/organisations/association/organisation'
      Puree::Extractor::Generic.multi_header xpath_result
    end

    def extract_owner
      xpath_result =  xpath_query '/owner'
      Puree::Extractor::Generic.header xpath_result
    end

    def extract_person
      xpath_result = xpath_query '/persons/participantAssociation'
      ::Puree::Extractor::Project.extract_person xpath_result
    end

    def extract_status
      xpath_query_for_single_value '/status/term/localizedString'
    end

    def extract_temporal
      o = {}
      o['expected'] = {}
      o['actual'] = {}

      xpath_result =  xpath_query '/expectedStartDate'
      o['expected']['start'] = xpath_result.text.strip

      xpath_result =  xpath_query '/expectedEndDate'
      o['expected']['end'] = xpath_result.text.strip

      xpath_result =  xpath_query '/startFinishDate/startDate'
      o['actual']['start'] = xpath_result.text.strip

      xpath_result =  xpath_query '/startFinishDate/endDate'
      o['actual']['end'] = xpath_result.text.strip

      o
    end

    def extract_title
      xpath_query_for_single_value '/title/localizedString'
    end

    def extract_type
      xpath_query_for_single_value '/typeClassification/term/localizedString'
    end

    def extract_url
      xpath_query_for_single_value '/projectURL'
    end

    def combine_metadata
      o = super
      o['acronym'] = extract_acronym
      o['description'] = extract_description
      o['organisation'] = extract_organisation
      o['owner'] = extract_owner
      o['person'] = extract_person
      o['status'] = extract_status
      o['temporal'] = extract_temporal
      o['title'] = extract_title
      o['type'] = extract_type
      o['url'] = extract_url
      @metadata = o
    end

  end

end
