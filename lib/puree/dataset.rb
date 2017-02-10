module Puree

  # Dataset resource
  #
  class Dataset < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :dataset,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Open access permission
    #
    # @return [String]
    def access
      @metadata['access']
    end

    # Combines project and publication
    #
    # @return [Array<Hash>]
    def associated
      @metadata['associated']
    end

    # Date made available
    #
    # @return [Hash]
    def available
      @metadata['available']
    end

    # Description
    #
    # @return [String]
    def description
      @metadata['description']
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

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      @metadata['keyword']
    end

    # Link
    #
    # @return [Array<Hash>]
    def link
      @metadata['link']
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
    # @return [Array<Hash>]
    def person
      @metadata['person']
    end

    # Date of data production
    #
    # @return [Hash]
    def production
      @metadata['production']
    end

    # Project
    #
    # @return [Array<Hash>]
    def project
      @metadata['project']
    end

    # Publication
    #
    # @return [Array<Hash>]
    def publication
      @metadata['publication']
    end

    # Publisher
    #
    # @return [String]
    def publisher
      @metadata['publisher']
    end

    # Spatial coverage (place names)
    #
    # @return [Array<String>]
    def spatial
      @metadata['spatial']
    end

    # Spatial coverage point
    #
    # @return [Hash]
    def spatial_point
      @metadata['spatial_point']
    end

    # Temporal coverage
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

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end

    private

    def combine_metadata
      extractor = Puree::Extractor::Dataset.new resource_type: :dataset,
                                                xml: @response.body
      o = super
      o['access'] = extractor.access
      o['associated'] = extractor.associated
      o['available'] = extractor.available
      o['description'] = extractor.description
      o['doi'] = extractor.doi
      o['file'] = extractor.file
      o['keyword'] = extractor.keyword
      o['link'] = extractor.link
      o['organisation'] = extractor.organisation
      o['owner'] = extractor.owner
      o['person'] = extractor.person
      o['project'] = extractor.project
      o['production'] = extractor.production
      o['publication'] = extractor.publication
      o['publisher'] = extractor.publisher
      o['spatial'] = extractor.spatial
      o['spatial_point'] = extractor.spatial_point
      o['temporal'] = extractor.temporal
      o['title'] = extractor.title
      @metadata = o
    end

  end

end