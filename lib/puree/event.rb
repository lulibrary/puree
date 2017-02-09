module Puree

  # Event resource
  #
  class Event < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :event,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end


    # City
    #
    # @return [String]
    def city
      @metadata['city']
    end

    # Country
    #
    # @return [String]
    def country
      @metadata['country']
    end

    # Date
    #
    # @return [Hash]
    def date
      @metadata['date']
    end

    # Description
    #
    # @return [String]
    def description
      @metadata['description']
    end

    # Location
    #
    # @return [String]
    def location
      @metadata['location']
    end

    # Title
    #
    # @return [String]
    def title
      @metadata['title']
    end

    # Type
    #
    # @return [String]
    def type
      @metadata['type']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end

    private

    def extract_city
      xpath_query('/city').text.strip
    end

    def extract_country
      xpath_query('/country/term/localizedString').text.strip
    end

    def extract_date
      xpath_result = xpath_query '/dateRange'
      ::Puree::Extractor::Event.extract_date xpath_result
    end

    def extract_description
      xpath_query('/description').text.strip
    end

    def extract_location
      xpath_query('/location').text.strip
    end

    def extract_title
      xpath_query_for_single_value '/title/localizedString'
    end

    def extract_type
      xpath_query_for_single_value '//typeClassification/term/localizedString'
    end

    def combine_metadata
      o = super
      o['city'] = extract_city
      o['country'] = extract_country
      o['date'] = extract_date
      o['description'] = extract_description
      o['location'] = extract_location
      o['title'] = extract_title
      o['type'] = extract_type
      @metadata = o
    end

  end

end
