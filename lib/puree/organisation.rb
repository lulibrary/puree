module Puree

  # Organisation resource
  #
  class Organisation < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :organisation,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Address
    #
    # @return [Array<Hash>]
    def address
      @metadata['address']
    end

    # Email
    #
    # @return [Array<String>]
    def email
      @metadata['email']
    end

    # Name
    #
    # @return [String]
    def name
      @metadata['name']
    end

    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
      @metadata['organisation']
    end

    # Parent
    #
    # @return [Hash]
    def parent
      @metadata['parent']
    end

    # Phone
    #
    # @return [Array<String>]
    def phone
      @metadata['phone']
    end

    # Type
    #
    # @return [String]
    def type
      @metadata['type']
    end

    # URL
    #
    # @return [Array<String>]
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
      o['address'] = @extractor.address
      o['email'] = @extractor.email
      o['name'] = @extractor.name
      o['organisation'] = @extractor.organisation
      o['parent'] = @extractor.parent
      o['phone'] = @extractor.phone
      o['type'] = @extractor.type
      o['url'] = @extractor.url
      @metadata = o
    end

  end

end
