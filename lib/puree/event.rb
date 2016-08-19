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
      path = '/city'
      xpath_query(path).text.strip
    end

    def extract_country
      path = '/country/term/localizedString'
      xpath_query(path).text.strip
    end

    def extract_date
      data = {}
      path = '/dateRange'
      range = xpath_query path
      data['start'] = range.xpath('startDate').text.strip
      data['end'] = range.xpath('startDate').text.strip
      data
    end

    def extract_description
      path = '/description'
      xpath_query(path).text.strip
    end

    def extract_location
      path = '/location'
      xpath_query(path).text.strip
    end

    def extract_title
      path = '/title/localizedString'
      xpath_query_for_single_value path
    end

    def extract_type
      path = '//typeClassification/term/localizedString'
      xpath_query_for_single_value path
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
