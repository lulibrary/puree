module Puree

  # Person resource
  #
  class Person < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :person,
            endpoint: endpoint,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end



    # Affiliation
    #
    # @return [Array<Hash>]
    def affiliation
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

    # Email
    #
    # @return [Array]
    def email
      path = '//emails/classificationDefinedStringFieldExtension/value'
      xpath_result =  xpath_query path
      data = []
      xpath_result.each { |i| data << i.text }
      data.uniq
    end

    # Image URL
    #
    # @return [Array<String>]
    def image
      path = '//photos/file/url'
      xpath_result =  xpath_query path
      data = []
      xpath_result.each { |i| data << i.text }
      data.uniq
    end

    # Keyword
    #
    # @return [Array<String>]
    def keyword
      path = '//keywordGroup/keyword/userDefinedKeyword/freeKeyword'
      xpath_result =  xpath_query path
      data = []
      xpath_result.each { |i| data << i.text }
      data.uniq
    end

    # Name
    #
    # @return [Hash]
    def name
      data = node 'name'
      o = {}
      if !data.nil? && !data.empty?
        o['first'] = data['firstName'].strip
        o['last'] = data['lastName'].strip
      end
      o
    end

    # ORCID
    #
    # @return [String]
    def orcid
      data = node 'orcid'
      !data.nil? && !data.empty? ? data.strip : ''
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['affiliation'] = affiliation
      o['email'] = email
      o['image'] = image
      o['keyword'] = keyword
      o['name'] = name
      o['orcid'] = orcid
      o
    end

  end

end
