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
    # @return [String]
    def page
      @metadata['page']
    end

    # Person (internal, external, other)
    #
    # @return [Hash<Array,Array,Array>]
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
      xpath_query_for_single_value '/publicationCategory/publicationCategory/term/localizedString'
    end

    def extract_description
      xpath_query_for_single_value '/abstract/localizedString'
    end

    def extract_event
      xpath_result = xpath_query '/event'
      Puree::Extractor::Publication.extract_event xpath_result
    end

    def extract_doi
      xpath_query_for_single_value '//doi'
    end

    def extract_file
      xpath_result = xpath_query '/electronicVersionAssociations/electronicVersionFileAssociations/electronicVersionFileAssociation/file'
      Puree::Extractor::Publication.extract_file xpath_result
    end

    def extract_organisation
      xpath_result = xpath_query '/organisations/association/organisation'
      Puree::Extractor::Generic.multi_header xpath_result
    end

    def extract_page
      xpath_query_for_single_value '/numberOfPages'
    end

    def extract_person
      xpath_result = xpath_query '/persons/personAssociation'
      Puree::Extractor::Publication.extract_person xpath_result
    end

    def extract_status
      xpath_result = xpath_query '/publicationStatuses/publicationStatus'
      Puree::Extractor::Publication.extract_status xpath_result
    end

    def extract_title
      xpath_query_for_single_value '/title'
    end

    def extract_subtitle
      xpath_query_for_single_value '/subtitle'
    end

    def extract_type
      xpath_query_for_single_value '/typeClassification/term/localizedString'
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
