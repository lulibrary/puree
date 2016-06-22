module Puree

  # Journal resource
  #
  class Journal < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    # @param optional basic_auth [Boolean]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :journal,
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
