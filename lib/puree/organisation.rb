module Puree

  # Organisation resource
  #
  class Organisation < Resource

    # @param base_url [String]
    # @param username [String]
    # @param password [String]
    # @param basic_auth [Boolean]
    def initialize(base_url: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :organisation,
            base_url: base_url,
            username: username,
            password: password,
            basic_auth: basic_auth)
    end

    # Address
    #
    # @return [Array<Hash>]
    def address
      @metadata['address']
    end

    # Email
    #
    # @return [Array<String>]
    def email
      @metadata['email']
    end

    # Name
    #
    # @return [String]
    def name
      @metadata['name']
    end

    # Organisation
    #
    # @return [Array<Hash>]
    def organisation
      @metadata['organisation']
    end

    # Parent
    #
    # @return [Hash]
    def parent
      @metadata['parent']
    end

    # Phone
    #
    # @return [Array<String>]
    def phone
      @metadata['phone']
    end

    # Type
    #
    # @return [String]
    def type
      @metadata['type']
    end

    # URL
    #
    # @return [Array<String>]
    def url
      @metadata['url']
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    def extract_address
      path = '/addresses/classifiedAddress'
      xpath_result = xpath_query path

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

    def extract_email
      path = '/emails/classificationDefinedStringFieldExtension/value'
      xpath_query_for_multi_value(path)
    end

    def extract_name
      path = '/name/localizedString'
      xpath_query_for_single_value path
    end

    def extract_organisation
      path = '/organisations/organisation'
      xpath_result =  xpath_query path
      Puree::Extractor::Generic.multi_header(xpath_result)
    end

    def extract_parent
      data = extract_organisation
      o = {}
      if !data.empty?
        o = data.first
      end
      o
    end

    def extract_phone
      path = '/phoneNumbers/classificationDefinedStringFieldExtension/value'
      xpath_query_for_multi_value(path)
    end

    def extract_type
      path = '/typeClassification/term/localizedString'
      xpath_query_for_single_value path
    end

    def extract_url
      path = '/webAddresses/classificationDefinedFieldExtension/value/localizedString'
      xpath_query_for_multi_value(path)
    end

    def combine_metadata
      o = super
      o['address'] = extract_address
      o['email'] = extract_email
      o['name'] = extract_name
      o['organisation'] = extract_organisation
      o['parent'] = extract_parent
      o['phone'] = extract_phone
      o['type'] = extract_type
      o['url'] = extract_url
      @metadata = o
    end

  end

end
