module Puree

  # Project resource
  #
  class Project < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil)
      super(api: :project,
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