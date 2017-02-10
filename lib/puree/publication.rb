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

    def combine_metadata
      o = super
      o['category'] = @extractor.category
      o['description'] = @extractor.description
      o['doi'] = @extractor.doi
      o['event'] = @extractor.event
      o['file'] = @extractor.file
      o['organisation'] = @extractor.organisation
      o['page'] = @extractor.page
      o['person'] = @extractor.person
      o['status'] = @extractor.status
      o['subtitle'] = @extractor.subtitle
      o['title'] = @extractor.title
      o['type'] = @extractor.type
      @metadata = o
    end

  end

end
