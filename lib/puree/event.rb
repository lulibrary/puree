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

    def combine_metadata
      o = super
      o['city'] = @extractor.city
      o['country'] = @extractor.country
      o['date'] = @extractor.date
      o['description'] = @extractor.description
      o['location'] = @extractor.location
      o['title'] = @extractor.title
      o['type'] = @extractor.type
      @metadata = o
    end

  end

end
