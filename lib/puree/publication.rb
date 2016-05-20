module Puree

  # Publication resource
  #
  class Publication < Resource

    def initialize
      super(:publication)
    end

    # Description
    #
    # @return [String]
    def description
      path = '//abstract/localizedString'
      xpath_result =  xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Digital Object Identifier
    #
    # @return [String]
    def doi
      path = '//doi'
      xpath_result =  xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Supporting file
    #
    # @return [Array<Hash>]
    def file
      path = '//electronicVersionFileAssociations/electronicVersionFileAssociation/file'
      xpath_result =  xpath_query path
      docs = []
      xpath_result.each do |d|
        doc = {}
        # doc['id'] = d.xpath('id').text
        doc['name'] = d.xpath('fileName').text.strip
        doc['mime'] = d.xpath('mimeType').text.strip
        doc['size'] = d.xpath('size').text.strip
        doc['url'] = d.xpath('url').text.strip
        docs << doc
      end
      docs.uniq
    end

    # Title
    #
    # @return [String]
    def title
      path = '//content/title'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Subtitle
    #
    # @return [String]
    def subtitle
      path = '//content/subtitle'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['description'] = description
      o['doi'] = doi
      o['file'] = file
      o['subtitle'] = subtitle
      o['title'] = title
      o
    end

  end

end
