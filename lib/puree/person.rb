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
      xpath_result =  xpath_doc.xpath path
      affiliations = []
      xpath_result.each { |i| affiliations << i.text }
      return affiliations.uniq
    end

    # ORCID
    #
    # @return [String]
    def orcid
      data = node 'orcid'
      if !data.nil? && !data.empty?
        !data.nil? && !data.empty? ? data : ''
      else
        ''
      end
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = {}
      o['affiliation'] = affiliation
      o['orcid'] = orcid
      o
    end

  end

end
