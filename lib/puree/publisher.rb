module Puree

  # Publisher resource
  #
  class Publisher < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :publisher,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
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
      @metadata = o
    end

  end

end
