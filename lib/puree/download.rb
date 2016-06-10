module Puree

  # Download resource
  #
  class Download < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil)
      super(api: :download,
            endpoint: endpoint,
            username: username,
            password: password)
    end

    # All metadata
    #
    # @return [Hash]
    # def metadata
    #   super
    # end

  end

end
