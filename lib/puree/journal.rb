module Puree

  # Journal resource
  #
  class Journal < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :journal,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # ISSN
    #
    # @return [String]
    def issn
      @metadata['issn']
    end

    # Publisher
    #
    # @return [String]
    def publisher
      @metadata['publisher']
    end

    # Title
    #
    # @return [String]
    def title
      @metadata['title']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    def extract_issn
      xpath_query_for_single_value '/issns/issn/string'
    end

    def extract_publisher
      xpath_query_for_single_value '/publisher/name'
    end

    def extract_title
      xpath_query_for_single_value '/titles/title/string'
    end

    def combine_metadata
      o = super
      o['issn'] = extract_issn
      o['publisher'] = extract_publisher
      o['title'] = extract_title
      @metadata = o
    end

  end

end
