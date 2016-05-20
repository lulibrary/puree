module Puree

  # Person resource
  #
  class Person < Resource

    def initialize
      super(:person)
    end

    # Affiliation
    #
    # @return [Array<String>]
    def affiliation
      path = '//organisation/name/localizedString'
      xpath_result =  xpath_query path
      affiliations = []
      xpath_result.each { |i| affiliations << i.text }
      affiliations.uniq
    end

    # Image
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
      o['image'] = image
      o['keyword'] = keyword
      o['name'] = name
      o['orcid'] = orcid
      o
    end

  end

end
