module Puree

  # Publisher resource
  #
  class Publisher < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :publisher,
            endpoint: endpoint,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end



    # All metadata
    #
    # @return [Hash]
    def metadata
      super
    end

  end

end
