module Puree

  # Publication resource
  #
  class Publication < Resource

    def initialize
      super(:publication)
    end

    # Description
    #
    # @return [Array<String>]
    def description
      path = '//abstract/localizedString'
      xpath_result =  xpath_query path
      data_arr = []
      xpath_result.each { |i| data_arr << i.text }
      data_arr.uniq
    end

    # Digital Object Identifier
    #
    # @return [String]
    def doi
      path = '//doi'
      xpath_result =  xpath_query path
      xpath_result ? xpath_result.text : ''
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
        doc['name'] = d.xpath('fileName').text
        doc['mime'] = d.xpath('mimeType').text
        doc['size'] = d.xpath('size').text
        doc['url'] = d.xpath('url').text
        docs << doc
      end
      docs.uniq
    end

    # Title
    #
    # @return [Array<String>]
    def title
      path = '//content/title'
      xpath_result =  xpath_query path
      data_arr = []
      xpath_result.each { |i| data_arr << i.text }
      data_arr.uniq
    end

    # Subtitle
    #
    # @return [Array<String>]
    def subtitle
      path = '//content/subtitle'
      xpath_result =  xpath_query path
      data_arr = []
      xpath_result.each { |i| data_arr << i.text }
      data_arr.uniq
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = {}
      o['description'] = description
      o['doi'] = doi
      o['file'] = file
      o['subtitle'] = subtitle
      o['title'] = title
      o
    end

  end

end
