module Puree

  # Project resource
  #
  class Project < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super
      @latest_api = false # stable API does not return person roles
      @resource_type = :project
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

    def combine_metadata
      o = super
      o['acronym'] = @extractor.acronym
      o['description'] = @extractor.description
      o['organisation'] = @extractor.organisation
      o['owner'] = @extractor.owner
      o['person'] = @extractor.person
      o['status'] = @extractor.status
      o['temporal'] = @extractor.temporal
      o['title'] = @extractor.title
      o['type'] = @extractor.type
      o['url'] = @extractor.url
      @metadata = o
    end

  end

end
