module Puree

  # Organisation resource
  #
  class Organisation < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil)
      super(api: :organisation,
            endpoint: endpoint,
            username: username,
            password: password)
    end

    # Address
    #
    # @return [Array<Hash>]
    def address
      path = '//addresses/classifiedAddress'
      xpath_result =  xpath_query path

      data = []

      xpath_result.each do |d|
        o = {}
        o['street'] = d.xpath('street').text.strip
        o['building'] = d.xpath('building').text.strip
        o['postcode'] = d.xpath('postalCode').text.strip
        o['city'] = d.xpath('city').text.strip
        o['country'] = d.xpath('country/term/localizedString').text.strip
        data << o
      end
      data.uniq
    end

    # Email
    #
    # @return [Array<String>]
    def email
      path = '//emails/classificationDefinedStringFieldExtension/value'
      xpath_result =  xpath_query path
      arr = []
      xpath_result.each { |i| arr << i.text.strip }
      arr.uniq
    end

    # Name
    #
    # @return [String]
    def name
      data = node 'name'
      !data.nil? && !data.empty? ? data['localizedString']['__content__'].strip : ''
    end

    # Parent
    #
    # @return [Hash]
    def parent
      data = organisation
      o = {}
      if !data.empty?
        o = data.first
      end
      o
    end

    # Phone
    #
    # @return [Array<String>]
    def phone
      path = '//phoneNumbers/classificationDefinedStringFieldExtension/value'
      xpath_result =  xpath_query path
      arr = []
      xpath_result.each { |i| arr << i.text.strip }
      arr.uniq
    end

    # Type
    #
    # @return [String]
    def type
      path = '//content/typeClassification/term/localizedString'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # URL
    #
    # @return [Array<String>]
    def url
      path = '//content/webAddresses/classificationDefinedFieldExtension/value/localizedString'
      xpath_result = xpath_query path
      arr = []
      xpath_result.each { |i| arr << i.text.strip }
      arr.uniq
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['address'] = address
      o['email'] = email
      o['name'] = name
      o['parent'] = parent
      o['phone'] = phone
      o['type'] = type
      o['url'] = url
      o
    end


    private


    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
      path = '//organisations/organisation'
      xpath_result =  xpath_query path

      data = []

      xpath_result.each do |d|
        o = {}
        o['uuid'] = d.xpath('@uuid').text.strip
        o['name'] = d.xpath('name/localizedString').text.strip
        o['type'] = d.xpath('typeClassification/term/localizedString').text.strip
        data << o
      end
      data.uniq
    end


  end

end
