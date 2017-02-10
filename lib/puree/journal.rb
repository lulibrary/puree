module Puree

  # Journal resource
  #
  class Journal < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :journal,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # ISSN
    #
    # @return [String]
    def issn
      @metadata['issn']
    end

    # Publisher
    #
    # @return [String]
    def publisher
      @metadata['publisher']
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
      o = super
      o['issn'] = @extractor.issn
      o['publisher'] = @extractor.publisher
      o['title'] = @extractor.title
      @metadata = o
    end

  end

end
