module Puree

  # Person resource
  #
  class Person < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :person,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Affiliation
    #
    # @return [Array<Hash>]
    def affiliation
      @metadata['affiliation']
    end

    # Email
    #
    # @return [Array]
    def email
      @metadata['email']
    end

    # Image URL
    #
    # @return [Array<String>]
    def image
      @metadata['image']
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      @metadata['keyword']
    end

    # Name
    #
    # @return [Hash]
    def name
      @metadata['name']
    end

    # ORCID
    #
    # @return [String]
    def orcid
      @metadata['orcid']
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
      o['affiliation'] = @extractor.affiliation
      o['email'] = @extractor.email
      o['image'] = @extractor.image
      o['keyword'] = @extractor.keyword
      o['name'] = @extractor.name
      o['orcid'] = @extractor.orcid
      @metadata = o
    end

  end

end
