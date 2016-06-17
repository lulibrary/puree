module Puree

  # Event resource
  #
  class Event < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :event,
            endpoint: endpoint,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end




    # City
    #
    # @return [String]
    def city
      path = '//city'
      xpath_query(path).text.strip
    end

    # Country
    #
    # @return [String]
    def country
      path = '//country/term/localizedString'
      xpath_query(path).text.strip
    end

    # Date
    #
    # @return [Hash]
    def date
      data = {}
      path = '//dateRange'
      range = xpath_query path
      data['start'] = range.xpath('startDate').text.strip
      data['end'] = range.xpath('startDate').text.strip
      data
    end

    # Description
    #
    # @return [String]
    def description
      path = '//content/description'
      xpath_query(path).text.strip
    end

    # Location
    #
    # @return [String]
    def location
      path = '//location'
      xpath_query(path).text.strip
    end

    # Title
    #
    # @return [String]
    def title
      path = '//title/localizedString'
      xpath_query(path).text.strip
    end

    # Type
    #
    # @return [String]
    def type
      path = '//content/typeClassification/term/localizedString'
      xpath_query(path).text.strip
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['city'] = city
      o['country'] = country
      o['date'] = date
      o['description'] = description
      o['location'] = location
      o['title'] = title
      o['type'] = type
      o
    end

  end

end
