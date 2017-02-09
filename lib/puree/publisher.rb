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

    # Name
    #
    # @return [String]
    def name
      @metadata['name']
    end

    # Adds no value as value is Publisher
    # Type
    #
    # @return [String]
    # def type
    #   @metadata['type']
    # end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    def extract_name
      xpath_query_for_single_value '/name'
    end

    # Adds no value as value is Publisher
    # def extract_type
    #   path = '/typeClassification/term/localizedString'
    #   xpath_query_for_single_value path
    # end

    def combine_metadata
      o = super
      o['name'] = extract_name
      # o['type'] = extract_type
      @metadata = o
    end

  end

end
