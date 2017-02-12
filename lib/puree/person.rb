module Puree

  # Person resource
  #
  class Person < Resource

    # @param base_url [String]
    def initialize(base_url: nil)
      super
      @resource_type = :person
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
