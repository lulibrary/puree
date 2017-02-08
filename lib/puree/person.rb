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
      xpath_result = xpath_query '//organisation'
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
      xpath_query_for_multi_value '//emails/classificationDefinedStringFieldExtension/value'
    end

    def extract_image
      xpath_query_for_multi_value '/photos/file/url'
    end

    def extract_keyword
      xpath_query_for_multi_value '//keywordGroup/keyword/userDefinedKeyword/freeKeyword'
    end

    def extract_name
      xpath_result = xpath_query '/name'
      first = xpath_result.xpath('firstName').text.strip
      last = xpath_result.xpath('lastName').text.strip
      o = {}
      o['first'] = first
      o['last'] = last
      o
    end

    def extract_orcid
      xpath_query_for_single_value '/orcid'
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
