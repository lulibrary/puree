module Puree

  # Person resource
  #
  class Person < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :person,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Affiliation
    #
    # @return [Array<Hash>]
    def affiliation
      @metadata['affiliation']
    end

    # Email
    #
    # @return [Array]
    def email
      @metadata['email']
    end

    # Image URL
    #
    # @return [Array<String>]
    def image
      @metadata['image']
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      @metadata['keyword']
    end

    # Name
    #
    # @return [Hash]
    def name
      @metadata['name']
    end

    # ORCID
    #
    # @return [String]
    def orcid
      @metadata['orcid']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end

    private

    def extract_affiliation
      path = '//organisation'
      xpath_result =  xpath_query path
      data_arr = []
      xpath_result.each { |i|
        data = {}
        data['uuid'] = i.attr('uuid').strip
        data['name'] = i.xpath('name/localizedString').text.strip
        data_arr << data
      }
      data_arr.uniq
    end

    def extract_email
      path = '//emails/classificationDefinedStringFieldExtension/value'
      xpath_query_for_multi_value(path)
    end

    def extract_image
      path = '/photos/file/url'
      xpath_query_for_multi_value(path)
    end

    def extract_keyword
      path = '//keywordGroup/keyword/userDefinedKeyword/freeKeyword'
      xpath_query_for_multi_value(path)
    end

    def extract_name
      path = '/name'
      xpath_result =  xpath_query path
      first = xpath_result.xpath('firstName').text.strip
      last = xpath_result.xpath('lastName').text.strip
      o = {}
      o['first'] = first
      o['last'] = last
      o
    end

    def extract_orcid
      path = '/orcid'
      xpath_query_for_single_value path
    end

    def combine_metadata
      o = super
      o['affiliation'] = extract_affiliation
      o['email'] = extract_email
      o['image'] = extract_image
      o['keyword'] = extract_keyword
      o['name'] = extract_name
      o['orcid'] = extract_orcid
      @metadata = o
    end

  end

end
