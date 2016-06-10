module Puree

  # Journal resource
  #
  class Journal < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil)
      super(api: :journal,
            endpoint: endpoint,
            username: username,
            password: password)
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      super
    end

  end

end
